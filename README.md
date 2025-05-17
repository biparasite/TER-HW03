# Домашнее задание к занятию " `Управляющие конструкции в коде Terraform` " - `Сулименков Алексей`

---

## Задание 1

1. Изучите проект.
2. Инициализируйте проект, выполните код.

Приложите скриншот входящих правил «Группы безопасности» в ЛК Yandex Cloud .

---

### Ответ

<details> <summary>Группы безопасности» в ЛК Yandex Cloud</summary>

![task1](https://github.com/biparasite/TER-HW03/blob/main/task_1.1.png "task1")

 </details>

---

## Задание 2

1. Создайте файл count-vm.tf. Опишите в нём создание двух **одинаковых** ВМ web-1 и web-2 (не web-0 и web-1) с минимальными параметрами, используя мета-аргумент **count loop**. Назначьте ВМ созданную в первом задании группу безопасности.(как это сделать узнайте в документации провайдера yandex/compute_instance )
2. Создайте файл for_each-vm.tf. Опишите в нём создание двух ВМ для баз данных с именами "main" и "replica" **разных** по cpu/ram/disk_volume , используя мета-аргумент **for_each loop**. Используйте для обеих ВМ одну общую переменную типа:

```
variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number }))
}
```

При желании внесите в переменную все возможные параметры. 4. ВМ из пункта 2.1 должны создаваться после создания ВМ из пункта 2.2. 5. Используйте функцию file в local-переменной для считывания ключа ~/.ssh/id_rsa.pub и его последующего использования в блоке metadata, взятому из ДЗ 2. 6. Инициализируйте проект, выполните код.

---

### Ответ

1.

<details> <summary>count-vm.tf</summary>

```bash
resource "yandex_compute_instance" "web_servers" {
  count = 2

  name        = "web-${count.index + 1}"
  platform_id = var.vm_web_platform
  zone        = var.default_zone
  resources {
    cores         = var.vms_resources.web.cores
    memory        = var.vms_resources.web.memory
    core_fraction = var.vms_resources.web.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }

  metadata = var.metadata

}

```

</details>

2. for_each-vm.tf

<details> <summary>for_each-vm.tf</summary>

```bash
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

```

</details>

<details> <summary>Yandex Cloud</summary>

![task2](https://github.com/biparasite/TER-HW03/blob/main/task_2.1.png "task2")

</details>
