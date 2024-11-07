variable "yc_cloud" {
  type        = string
  description = "Yandex Cloud ID"
}

variable "yc_folder" {
  type        = string
  description = "Yandex Cloud folder"
}

variable "yc_token" {
  type        = string
  description = "Yandex Cloud OAuth token"
}

variable "vm_image_id" {
  description = "ID образа для виртуальных машин (например, Ubuntu)"
  type        = string
  default     = "fd8k3gggfrs13lk01m77"
}

variable "vm_platform_id" {
  description = "ID платформы для виртуальных машин (например, стандарт x86)"
  type        = string
  default     = "standard-v1"
}