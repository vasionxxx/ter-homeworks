###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "default_cidr_b" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}

variable "vpc_name_b" {
  type        = string
  default     = "develop_b"
  description = "VPC network & subnet name"
}

### РџРµСЂРµРјРµРЅРЅР°СЏ РґР»СЏ СЂРµСЃСѓСЂСЃРѕРІ Р’Рњ
variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
    hdd_size      = number
    hdd_type      = string
  }))
  description = "conf web and db"
  default = {
    web = {
      cores         = 2
      memory        = 1
      core_fraction = 5
      hdd_size      = 10
      hdd_type      = "network-hdd"
    },
    db = {
      cores         = 2
      memory        = 2
      core_fraction = 20
      hdd_size      = 10
      hdd_type      = "network-ssd"
    }
  }
}

###ssh vars

#variable "vms_ssh_root_key" {
#  type        = string
#  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzFTMNjMuxinhlghENDHAwjMhL98Qpu7EkUxP6gsP6dCuKewcxwAgR5xGJLcT+TjCa/DHYLtYguXvMerIVe5Zvw62V8gq3yqd+dl3q106RX07Vkzq31m6GDhL3VdBN0esAlnLH9i5mb0Rv3vcHuI6cKwFtK3yitkYCdieyisXYUHu5GsfKmmCmOAw176SD8LRjErwSivMMP/tBZfaGyfoJxm9EVk6iSucGlF4asoC1szICV4+YiXpN5TmO1/lzRl0YmOXkgTCu/sgfEdC8jGpGdfUeZhpfhNcA2JEuNQUJaikvZqsrfc7MQpdge/r4Plqh5QL8LBR5eJvhNZgl1Z+d rsa-key-20250126"
#  description = "ssh-keygen -t ed25519"
#}

variable "metadata" {
  description = "meta_all"
  type = object({
    serial_port_enable = number
    ssh_keys           = string
  })
  default = {
    serial_port_enable = 1
    ssh_keys           = "ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCzFTMNjMuxinhlghENDHAwjMhL98Qpu7EkUxP6gsP6dCuKewcxwAgR5xGJLcT+TjCa/DHYLtYguXvMerIVe5Zvw62V8gq3yqd+dl3q106RX07Vkzq31m6GDhL3VdBN0esAlnLH9i5mb0Rv3vcHuI6cKwFtK3yitkYCdieyisXYUHu5GsfKmmCmOAw176SD8LRjErwSivMMP/tBZfaGyfoJxm9EVk6iSucGlF4asoC1szICV4+YiXpN5TmO1/lzRl0YmOXkgTCu/sgfEdC8jGpGdfUeZhpfhNcA2JEuNQUJaikvZqsrfc7MQpdge/r4Plqh5QL8LBR5eJvhNZgl1Z+d rsa-key-20250126"
  }
}
