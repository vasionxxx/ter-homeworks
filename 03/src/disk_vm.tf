resource "yandex_compute_disk" "storage_disks" {
  count = length(var.storage_disks)

  name     = var.storage_disks[count.index].name
  type     = var.storage_disks[count.index].type
  zone     = var.default_zone
  size     = var.storage_disks[count.index].size
}

resource "yandex_compute_instance" "storage" {
  count = var.vm_storage_count

  name        = "storage-${count.index + 1}"
  platform_id = "standard-v2"
  zone        = var.default_zone

  resources {
    cores  = var.vm_storage_resources.cores
    memory = var.vm_storage_resources.memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = var.vm_storage_resources.disk
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

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }
}
