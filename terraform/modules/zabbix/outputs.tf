output "zabbix_public_ip" {
  value = yandex_compute_instance.zabbix.network_interface.0.nat_ip_address
}