output "postgres_host" {
  value       = yandex_mdb_postgresql_cluster.keycloak_db.host[0].fqdn
  description = "PostgreSQL hostname or IP address for Keycloak."
}

output "postgres_port" {
  value       = 6432
  description = "PostgreSQL port number."
}

output "postgres_db_name" {
  value       = yandex_mdb_postgresql_database.db.name
  description = "Database name for Keycloak."
}

output "postgres_user" {
  value       = yandex_mdb_postgresql_user.keycloak_user.name
  description = "Username for PostgreSQL."
}

output "postgres_password" {
  value       = yandex_mdb_postgresql_user.keycloak_user.password
  description = "Password for PostgreSQL."
  sensitive   = true
}