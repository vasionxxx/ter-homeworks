### Общие переменные
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

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

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

### Переменные для ВМ
variable "vm_web_count" {
  type        = number
  default     = 2
  description = "Количество веб-серверов"
}

variable "vm_storage_count" {
  type        = number
  default     = 1
  description = "Количество хранилищ"
}

variable "vm_web_resources" {
  type = object({
    cores  = number
    memory = number
    disk   = number
  })
  default = {
    cores  = 2
    memory = 2
    disk   = 10
  }
}

variable "vm_storage_resources" {
  type = object({
    cores  = number
    memory = number
    disk   = number
  })
  default = {
    cores  = 2
    memory = 4
    disk   = 10
  }
}

variable "vm_db_resources" {
  type = list(object({
    vm_name     = string
    cpu         = number
    ram         = number
    disk_volume = number
  }))
  default = [
    {
      vm_name     = "main"
      cpu         = 2
      ram         = 2
      disk_volume = 20
    },
    {
      vm_name     = "replica"
      cpu         = 2
      ram         = 2
      disk_volume = 20
    }
  ]
}

### Переменные для образов
variable "image_family" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Семейство образов для ВМ"
}

### Переменные для дисков
variable "storage_disks" {
  type = list(object({
    name = string
    type = string
    size = number
  }))
  default = [
    {
      name = "storage-disk-1"
      type = "network-hdd"
      size = 1
    },
    {
      name = "storage-disk-2"
      type = "network-hdd"
      size = 1
    },
    {
      name = "storage-disk-3"
      type = "network-hdd"
      size = 1
    }
  ]
}
