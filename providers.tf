terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }    
    local = {
      source  = "hashicorp/local"
    }
  }
}

provider "yandex" {
  /* token     = var.token */
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
  service_account_key_file = file("~/Downloads/authorized_key.json")
}
