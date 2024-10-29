package test

import (
	"flag"
	"fmt"
	"net"
	"os"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	_ "github.com/lib/pq"
	"golang.org/x/crypto/ssh"
)

var folder = flag.String("folder", "", "Folder ID in Yandex.Cloud")

func TestEndToEndDeploymentScenario(t *testing.T) {
	fixtureFolder := "../"

	test_structure.RunTestStage(t, "setup", func() {
		terraformOptions := &terraform.Options{
			TerraformDir: fixtureFolder,
			Vars: map[string]interface{}{
				"yc_folder": *folder,
			},
		}

		test_structure.SaveTerraformOptions(t, fixtureFolder, terraformOptions)
		terraform.InitAndApply(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "validate", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)

		// Получение публичного IP сервера, к которому подключаемся
		keycloakIP := terraform.Output(t, terraformOptions, "keycloak_public_ip")

		// Настройки SSH
		sshUser := "ubuntu"                        // Имя пользователя для SSH
		sshKeyPath := "C:/Users/minia/.ssh/id_rsa" // Путь к приватному ключу SSH

		privateKey, err := os.ReadFile(sshKeyPath)
		if err != nil {
			t.Fatalf("Unable to read private key file: %v", err)
		}

		signer, err := ssh.ParsePrivateKey(privateKey)
		if err != nil {
			t.Fatalf("Unable to parse private key: %v", err)
		}

		config := &ssh.ClientConfig{
			User: sshUser,
			Auth: []ssh.AuthMethod{
				ssh.PublicKeys(signer),
			},
			HostKeyCallback: ssh.InsecureIgnoreHostKey(),
			Timeout:         10 * time.Second,
		}

		address := net.JoinHostPort(keycloakIP, "22")
		client, err := ssh.Dial("tcp", address, config)
		if err != nil {
			t.Fatalf("Failed to connect via SSH: %v", err)
		}
		defer client.Close()

		// Проверка пинга
		sshSession, err := client.NewSession()
		if err != nil {
			t.Fatalf("Cannot create SSH session for ping: %v", err)
		}
		err = sshSession.Run("ping -c 1 8.8.8.8")
		if err != nil {
			t.Fatalf("Cannot ping 8.8.8.8: %v", err)
		}
		sshSession.Close()

		// Установка клиента PostgreSQL
		sshSession, err = client.NewSession()
		if err != nil {
			t.Fatalf("Cannot create SSH session for PostgreSQL client installation: %v", err)
		}
		installPostgresCommand := "sudo apt-get update && sudo apt-get install postgresql-client -y"
		err = sshSession.Run(installPostgresCommand)
		if err != nil {
			t.Fatalf("Failed to install PostgreSQL client: %v", err)
		}
		sshSession.Close()

		// Подключение к PostgreSQL для проверки подключения
		sshSession, err = client.NewSession()
		if err != nil {
			t.Fatalf("Cannot create SSH session for PostgreSQL connection: %v", err)
		}

		// Получение параметров подключения к базе данных
		dbHost := terraform.Output(t, terraformOptions, "postgres_host")
		dbUser := terraform.Output(t, terraformOptions, "postgres_user")
		dbPassword := terraform.Output(t, terraformOptions, "postgres_password")
		dbPort := terraform.Output(t, terraformOptions, "postgres_port")
		dbName := terraform.Output(t, terraformOptions, "postgres_db_name")

		checkDbCommand := fmt.Sprintf("PGPASSWORD=%s psql -h %s -U %s -p %s -d %s -c 'SELECT 1'", dbPassword, dbHost, dbUser, dbPort, dbName)
		output, err := sshSession.CombinedOutput(checkDbCommand)
		if err != nil {
			t.Fatalf("Failed to connect to PostgreSQL database: %v, output: %s", err, output)
		}

		fmt.Println("PostgreSQL database connection test successful, output:")
		fmt.Println(string(output))
		sshSession.Close()
	})

	test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)
		terraform.Destroy(t, terraformOptions)
	})
}
