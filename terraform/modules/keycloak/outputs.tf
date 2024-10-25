output "keycloak_public_ip" {
  value = yandex_compute_instance.keycloak.network_interface.0.nat_ip_address
}