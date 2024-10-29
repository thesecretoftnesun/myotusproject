# Виртуальные машины для Samba, Keycloak, PostgresSQL и Zabbix
module "samba" {
  source      = "./modules/samba"
  vm_name     = "samba-controller"
  vm_hostname = "samba"
  network_id  = yandex_vpc_network.main-network.id
  subnet_id   = yandex_vpc_subnet.samba-subnet.id
}

module "keycloak" {
  source      = "./modules/keycloak"
  vm_name     = "keycloak-server"
  vm_hostname = "keycloak"
  network_id  = yandex_vpc_network.main-network.id
  subnet_id   = yandex_vpc_subnet.keycloak-subnet.id
}

module "postgres" {
  source            = "./modules/postgres"
  name              = "keycloak-db"
  network_id        = yandex_vpc_network.main-network.id
  subnet_id         = yandex_vpc_subnet.keycloak-subnet.id
  db_name           = "db"
  db_user           = "keycloak_user"
  db_password       = sensitive("password")
}

module "zabbix" {
  source      = "./modules/zabbix"
  vm_name     = "zabbix-server"
  vm_hostname = "zabbix"
  network_id  = yandex_vpc_network.main-network.id
  subnet_id   = yandex_vpc_subnet.zabbix-subnet.id
}