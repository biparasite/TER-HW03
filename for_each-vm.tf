resource "yandex_compute_instance" "db_vms" {
  for_each = { for item in var.each_vm : item.vm_name => item }

  name                  = each.key
  zone                  = var.default_zone
  platform_id           = var.vm_web_platform 

  resources {
    cores                = each.value.cpu
    memory               = each.value.ram
    core_fraction = var.vms_resources.web.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk_volume
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }
  
  scheduling_policy {
    preemptible = true
  }

  metadata = var.metadata

}