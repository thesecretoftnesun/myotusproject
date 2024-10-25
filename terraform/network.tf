resource "yandex_vpc_network" "main_network" {
  name = "main-network"
}

resource "yandex_vpc_subnet" "samba_subnet" {
  name           = "samba-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main_network.id
  v4_cidr_blocks = ["10.0.1.0/24"] # Подсеть для Samba
}

resource "yandex_vpc_subnet" "keycloak_subnet" {
  name           = "keycloak-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main_network.id
  v4_cidr_blocks = ["10.0.2.0/24"] # Подсеть для Keycloak
}

resource "yandex_vpc_subnet" "postgres_subnet" {
  name           = "postgres-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main_network.id
  v4_cidr_blocks = ["10.0.3.0/24"] # Подсеть для PostgreSQL
}

resource "yandex_vpc_subnet" "zabbix_subnet" {
  name           = "zabbix-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.main_network.id
  v4_cidr_blocks = ["10.0.4.0/24"] # Подсеть для Zabbix
}