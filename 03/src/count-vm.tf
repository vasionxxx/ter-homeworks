resource "yandex_compute_instance" "web" {
  count = var.vm_web_count

  name        = "web-${count.index + 1}"
  platform_id = "standard-v2"
  zone        = var.default_zone

  resources {
    cores  = var.vm_web_resources.cores
    memory = var.vm_web_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_web_resources.disk
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}
