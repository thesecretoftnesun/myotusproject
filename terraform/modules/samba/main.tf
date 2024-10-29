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