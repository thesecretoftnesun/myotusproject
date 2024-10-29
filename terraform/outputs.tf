output "samba_public_ip" {
  value = module.samba.samba_public_ip
}

output "keycloak_public_ip" {
  description = "Публичный IP-адрес Keycloak"
  value       = module.keycloak.keycloak_public_ip
}

output "postgres_host" {
  value       = module.postgres.postgres_host
  description = "PostgreSQL hostname or IP address for Keycloak."
}

output "postgres_port" {
  value       = module.postgres.postgres_port
  description = "PostgreSQL port number."
}

output "postgres_db_name" {
  value       = module.postgres.postgres_db_name
  description = "Database name for Keycloak."
}

output "postgres_user" {
  value       = module.postgres.postgres_user
  description = "Username for PostgreSQL."
}

output "postgres_password" {
  value       = module.postgres.postgres_password
  description = "Password for PostgreSQL."
  sensitive   = true
}

output "zabbix_public_ip" {
  value = module.zabbix.zabbix_public_ip
}
