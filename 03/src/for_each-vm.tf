resource "yandex_compute_instance" "db" {
  for_each = { for idx, vm in var.each_vm : idx => vm }

  name        = each.value.vm_name
  platform_id = "standard-v2"
  zone        = var.default_zone

  resources {
    cores  = each.value.cpu
    memory = each.value.ram
  }

  boot_disk {
    initialize_params {
      image_id = "fd81hgrcv6lsnkremf32" # РџСЂРёРјРµСЂ ID РѕР±СЂР°Р·Р° Ubuntu 20.04
      size     = each.value.disk_volume
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

  depends_on = [yandex_compute_instance.web] # Р—Р°РІРёСЃРёРјРѕСЃС‚СЊ РѕС‚ Р’Рњ РёР· count-vm.tf
}
