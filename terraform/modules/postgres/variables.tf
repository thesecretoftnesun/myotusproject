variable "name" {
  description = "Имя кластера PostgreSQL"
  type        = string
}

variable "network_id" {
  description = "ID сети VPC для подключения кластера"
  type        = string
}

variable "subnet_id" {
  description = "ID подсети для размещения PostgreSQL"
  type        = string
}

variable "db_name" {
  description = "Имя базы данных"
  type        = string
}

variable "db_user" {
  description = "Имя пользователя для базы данных"
  type        = string
}

variable "db_password" {
  description = "Password for PostgreSQL database"
  type        = string
  sensitive   = true
}