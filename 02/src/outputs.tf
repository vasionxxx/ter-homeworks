output "vm_web_instance_info" {
  value = {
    instance_name = yandex_compute_instance.platform.name
    external_ip   = yandex_compute_instance.platform.network_interface[0].ip_address
    fqdn          = yandex_compute_instance.platform.fqdn
  }
  description = "Instance information for the web VM"
}

output "vm_db_instance_info" {
  value = {
    instance_name = yandex_compute_instance.db.name
    external_ip   = yandex_compute_instance.db.network_interface[0].ip_address
    fqdn          = yandex_compute_instance.db.fqdn
  }
  description = "Instance information for the database VM"
}
