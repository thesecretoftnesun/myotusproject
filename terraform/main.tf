# Виртуальные машины для Samba, Keycloak, PostgresSQL и Zabbix
module "samba" {
  source      = "./modules/samba"
  vm_name     = "samba-controller"
  vm_hostname = "samba"
  network_id  = yandex_vpc_network.main_network.id
  subnet_id   = yandex_vpc_subnet.samba_subnet.id
}

module "keycloak" {
  source      = "./modules/keycloak"
  vm_name     = "keycloak-server"
  vm_hostname = "keycloak"
  network_id  = yandex_vpc_network.main_network.id
  subnet_id   = yandex_vpc_subnet.keycloak_subnet.id
}

module "postgres" {
  source      = "./modules/postgres"
  vm_name     = "postgres-server"
  vm_hostname = "postgres"
  network_id  = yandex_vpc_network.main_network.id
  subnet_id   = yandex_vpc_subnet.postgres_subnet.id
}

module "zabbix" {
  source      = "./modules/zabbix"
  vm_name     = "zabbix-server"
  vm_hostname = "zabbix"
  network_id  = yandex_vpc_network.main_network.id
  subnet_id   = yandex_vpc_subnet.zabbix_subnet.id
}