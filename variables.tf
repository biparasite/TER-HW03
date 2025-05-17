/*
 ###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
} 
*/

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
  description = "ru-central1-a-net-asv"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "VPC network ru-central1-a & 10.0.1.0/24"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network&subnet name"
}

variable "metadata" {
  type = map(string)
  description = "SSH key map"

}

variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "VM OS image"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "VM platform"
}

variable "vms_resources" {
  type = map(any)
  description = "VM resourses map"

}

variable "each_vm" {
  description = "Список конфигураций для всех виртуальных машин."
  type       = list(object({
    vm_name   = string,
    cpu       = number,
    ram       = number,
    disk_volume = number
  }))
}
