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

resource "yandex_compute_instance" "samba" {
  name = var.vm_name

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = var.vm_image_id
    }
  }

  network_interface {
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    user-data = <<-EOF
              #cloud-config
              packages:
                - samba
                - samba-common-bin
              runcmd:
                - systemctl start smbd
                - systemctl enable smbd
                - systemctl start nmbd
                - systemctl enable nmbd
              EOF
  }
}