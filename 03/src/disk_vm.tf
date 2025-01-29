# РЎРѕР·РґР°РЅРёРµ 3 РѕРґРёРЅР°РєРѕРІС‹С… РІРёСЂС‚СѓР°Р»СЊРЅС‹С… РґРёСЃРєРѕРІ
resource "yandex_compute_disk" "storage_disks" {
  count = 3

  name     = "storage-disk-${count.index + 1}"
  type     = "network-hdd"
  zone     = var.default_zone
  size     = 1 # Р Р°Р·РјРµСЂ РґРёСЃРєР° 1 Р“Р±
}

# РЎРѕР·РґР°РЅРёРµ РѕРґРёРЅРѕС‡РЅРѕР№ Р’Рњ "storage"
resource "yandex_compute_instance" "storage" {
  name        = "storage"
  platform_id = "standard-v2"
  zone        = var.default_zone

  resources {
    cores  = 2
    memory = 4
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32" # РџСЂРёРјРµСЂ ID РѕР±СЂР°Р·Р° Ubuntu 20.04
      size     = 10
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id] # РќР°Р·РЅР°С‡Р°РµРј РіСЂСѓРїРїСѓ Р±РµР·РѕРїР°СЃРЅРѕСЃС‚Рё
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}" # РСЃРїРѕР»СЊР·СѓРµРј SSH-РєР»СЋС‡
  }

  # Р”РёРЅР°РјРёС‡РµСЃРєРѕРµ РїРѕРґРєР»СЋС‡РµРЅРёРµ РґРѕРїРѕР»РЅРёС‚РµР»СЊРЅС‹С… РґРёСЃРєРѕРІ
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.storage_disks
    content {
      disk_id = secondary_disk.value.id
    }
  }
}
