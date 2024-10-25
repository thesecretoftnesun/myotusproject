output "samba_public_ip" {
  value = yandex_compute_instance.samba.network_interface.0.nat_ip_address
}
