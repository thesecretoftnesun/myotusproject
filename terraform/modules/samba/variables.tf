variable "vm_name" {
  description = "Имя виртуальной машины"
  type        = string
}

variable "vm_hostname" {
  description = "Хостнейм виртуальной машины"
  type        = string
}

variable "network_id" {
  description = "ID сети Yandex VPC"
  type        = string
}

variable "subnet_id" {
  description = "ID подсети Yandex VPC"
  type        = string
}

variable "vm_image_id" {
  description = "ID образа для виртуальных машин (например, Ubuntu)"
  type        = string
  default     = "fd80viupr3qjr5g6g9du" # Примерный ID образа
}

variable "vm_platform_id" {
  description = "ID платформы для виртуальных машин (например, стандарт x86)"
  type        = string
  default     = "standard-v1"
}