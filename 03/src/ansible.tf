# Р›РѕРєР°Р»СЊРЅС‹Рµ РїРµСЂРµРјРµРЅРЅС‹Рµ РґР»СЏ СЃР±РѕСЂР° РґР°РЅРЅС‹С… Рѕ Р’Рњ
locals {
  webservers = [
    for vm in yandex_compute_instance.web : {
      name       = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn       = vm.fqdn
    }
  ]

  databases = [
    for vm in yandex_compute_instance.db : {
      name       = vm.name
      external_ip = vm.network_interface[0].nat_ip_address
      fqdn       = vm.fqdn
    }
  ]

  storage = [
    {
      name       = yandex_compute_instance.storage.name
      external_ip = yandex_compute_instance.storage.network_interface[0].nat_ip_address
      fqdn       = yandex_compute_instance.storage.fqdn
    }
  ]
}

# РЎРѕР·РґР°РЅРёРµ inventory-С„Р°Р№Р»Р° РґР»СЏ Ansible
resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tftpl", {
    webservers = local.webservers
    databases  = local.databases
    storage    = local.storage
  })
  filename = "${path.module}/inventory.ini"
}
