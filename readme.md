# Задание
Вопросы по заданию
Преподаватель: Булат Замилов, Олег Букатчук, Руслан Жданов
Дипломный практикум в YandexCloud

# Цели:

1. Зарегистрировать доменное имя (любое на ваш выбор в любой доменной зоне).
2. Подготовить инфраструктуру с помощью Terraform на базе облачного провайдера YandexCloud.
3. Настроить внешний Reverse Proxy на основе Nginx и LetsEncrypt.
4. Настроить кластер MySQL.
5. Установить WordPress.
6. Развернуть Gitlab CE и Gitlab Runner.
7. Настроить CI/CD для автоматического развёртывания приложения.
8. Настроить мониторинг инфраструктуры с помощью стека: Prometheus, Alert Manager и Grafana.

# Этапы выполнения:

1. Регистрация доменного имени

Зарегистрирован домен у регистратора reg.ru.
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20010915.png)

2.  Создание инфраструктуры.
Предварительная подготовка:
Создаем сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. 

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-18%20010152.png)

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-19%20004331.png)

Подготовим backend для Terraform, будем использовать альтернативный вариант: S3 bucket в созданном YC аккаунте.

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-19%20015235.png)

3. Настройка workspaces

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-19%20013454.png)

4. Создайте VPC с подсетями в разных зонах доступности.
network.tf
# Задание
Вопросы по заданию
Преподаватель: Булат Замилов, Олег Букатчук, Руслан Жданов
Дипломный практикум в YandexCloud

# Цели:

1. Зарегистрировать доменное имя (любое на ваш выбор в любой доменной зоне).
2. Подготовить инфраструктуру с помощью Terraform на базе облачного провайдера YandexCloud.
3. Настроить внешний Reverse Proxy на основе Nginx и LetsEncrypt.
4. Настроить кластер MySQL.
5. Установить WordPress.
6. Развернуть Gitlab CE и Gitlab Runner.
7. Настроить CI/CD для автоматического развёртывания приложения.
8. Настроить мониторинг инфраструктуры с помощью стека: Prometheus, Alert Manager и Grafana.

# Этапы выполнения:

1. Регистрация доменного имени

Зарегистрирован домен у регистратора reg.ru.
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20010915.png)

2.  Создание инфраструктуры.
Предварительная подготовка:
Создаем сервисный аккаунт, который будет в дальнейшем использоваться Terraform для работы с инфраструктурой с необходимыми и достаточными правами. 

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-18%20010152.png)

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-19%20004331.png)

Подготовим backend для Terraform, будем использовать альтернативный вариант: S3 bucket в созданном YC аккаунте.

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-19%20015235.png)

3. Настройка workspaces

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-19%20013454.png)

4. Создайте VPC с подсетями в разных зонах доступности.
network.tf
````
    # Network
    resource "yandex_vpc_network" "default" {
      name = "net"
    }
    
    resource "yandex_vpc_subnet" "subnet" {
      count                   = 2
      name                    = format("subnet-%02d", count.index + 1)
      zone                    = var.zones[count.index]
      network_id              = yandex_vpc_network.default.id
      v4_cidr_blocks          = [var.CIDR_blocks[count.index]]
      route_table_id = yandex_vpc_route_table.nat-table.id
    }
    
    resource "yandex_vpc_route_table" "nat-table" {
      name = "everything-to-internal"
      network_id = "${yandex_vpc_network.default.id}"
    
      static_route {
        destination_prefix = "0.0.0.0/0"
        next_hop_address   = "192.168.100.100"
      }
    }
````
5. Убедитесь, что теперь вы можете выполнить команды terraform destroy и terraform apply без дополнительных ручных действий.

````
root@DESKTOP-6BS89JJ:/home/nonstop/diplom/src/terraform# terraform apply -var-file="tfvariables.tfvars"

Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # local_file.inventory will be created
  + resource "local_file" "inventory" {
      + content              = (known after apply)
      + directory_permission = "0777"
      + file_permission      = "0644"
      + filename             = "../ansible/inventory/inventory.yml"
      + id                   = (known after apply)
    }

  # yandex_compute_instance.app will be created
  + resource "yandex_compute_instance" "app" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "app"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = "centos:"
        }
      + name                      = "app"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd81u2vhv3mc49l1ccbb"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = false
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.db01 will be created
  + resource "yandex_compute_instance" "db01" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "db01"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = "centos:"
        }
      + name                      = "db01"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd81u2vhv3mc49l1ccbb"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = false
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 4
          + memory        = 6
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.db02 will be created
  + resource "yandex_compute_instance" "db02" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "db02"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = "centos:"
        }
      + name                      = "db02"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-b"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd81u2vhv3mc49l1ccbb"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = false
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 4
          + memory        = 6
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.gitlab will be created
  + resource "yandex_compute_instance" "gitlab" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "gitlab"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = "centos:"
        }
      + name                      = "gitlab"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd81u2vhv3mc49l1ccbb"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = false
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 4
          + memory        = 10
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.monitoring will be created
  + resource "yandex_compute_instance" "monitoring" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "monitoring"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = "centos:"
        }
      + name                      = "monitoring"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd81u2vhv3mc49l1ccbb"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = false
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 2
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.proxy will be created
  + resource "yandex_compute_instance" "proxy" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "proxy"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = "centos:"
        }
      + name                      = "proxy"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-a"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd81u2vhv3mc49l1ccbb"
              + name        = "root-proxy"
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-nvme"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = "192.168.100.100"
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = true
          + nat_ip_address     = "62.84.115.46"
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_compute_instance.runner will be created
  + resource "yandex_compute_instance" "runner" {
      + allow_stopping_for_update = true
      + created_at                = (known after apply)
      + folder_id                 = (known after apply)
      + fqdn                      = (known after apply)
      + hostname                  = "runner"
      + id                        = (known after apply)
      + metadata                  = {
          + "ssh-keys" = "centos:"
        }
      + name                      = "runner"
      + network_acceleration_type = "standard"
      + platform_id               = "standard-v1"
      + service_account_id        = (known after apply)
      + status                    = (known after apply)
      + zone                      = "ru-central1-b"

      + boot_disk {
          + auto_delete = true
          + device_name = (known after apply)
          + disk_id     = (known after apply)
          + mode        = (known after apply)

          + initialize_params {
              + block_size  = (known after apply)
              + description = (known after apply)
              + image_id    = "fd81u2vhv3mc49l1ccbb"
              + name        = (known after apply)
              + size        = 10
              + snapshot_id = (known after apply)
              + type        = "network-hdd"
            }
        }

      + network_interface {
          + index              = (known after apply)
          + ip_address         = (known after apply)
          + ipv4               = true
          + ipv6               = (known after apply)
          + ipv6_address       = (known after apply)
          + mac_address        = (known after apply)
          + nat                = false
          + nat_ip_address     = (known after apply)
          + nat_ip_version     = (known after apply)
          + security_group_ids = (known after apply)
          + subnet_id          = (known after apply)
        }

      + placement_policy {
          + host_affinity_rules = (known after apply)
          + placement_group_id  = (known after apply)
        }

      + resources {
          + core_fraction = 20
          + cores         = 4
          + memory        = 4
        }

      + scheduling_policy {
          + preemptible = true
        }
    }

  # yandex_dns_recordset.domains[0] will be created
  + resource "yandex_dns_recordset" "domains" {
      + data    = [
          + "62.84.115.46",
        ]
      + id      = (known after apply)
      + name    = "@"
      + ttl     = 600
      + type    = "A"
      + zone_id = (known after apply)
    }

  # yandex_dns_recordset.domains[1] will be created
  + resource "yandex_dns_recordset" "domains" {
      + data    = [
          + "62.84.115.46",
        ]
      + id      = (known after apply)
      + name    = "www"
      + ttl     = 600
      + type    = "A"
      + zone_id = (known after apply)
    }

  # yandex_dns_recordset.domains[2] will be created
  + resource "yandex_dns_recordset" "domains" {
      + data    = [
          + "62.84.115.46",
        ]
      + id      = (known after apply)
      + name    = "gitlab"
      + ttl     = 600
      + type    = "A"
      + zone_id = (known after apply)
    }

  # yandex_dns_recordset.domains[3] will be created
  + resource "yandex_dns_recordset" "domains" {
      + data    = [
          + "62.84.115.46",
        ]
      + id      = (known after apply)
      + name    = "grafana"
      + ttl     = 600
      + type    = "A"
      + zone_id = (known after apply)
    }

  # yandex_dns_recordset.domains[4] will be created
  + resource "yandex_dns_recordset" "domains" {
      + data    = [
          + "62.84.115.46",
        ]
      + id      = (known after apply)
      + name    = "prometheus"
      + ttl     = 600
      + type    = "A"
      + zone_id = (known after apply)
    }

  # yandex_dns_recordset.domains[5] will be created
  + resource "yandex_dns_recordset" "domains" {
      + data    = [
          + "62.84.115.46",
        ]
      + id      = (known after apply)
      + name    = "alertmanager"
      + ttl     = 600
      + type    = "A"
      + zone_id = (known after apply)
    }

  # yandex_dns_zone.default will be created
  + resource "yandex_dns_zone" "default" {
      + created_at       = (known after apply)
      + description      = "desc"
      + folder_id        = (known after apply)
      + id               = (known after apply)
      + labels           = {
          + "label1" = "label-1-public"
        }
      + name             = "my-private-zone"
      + private_networks = (known after apply)
      + public           = true
      + zone             = "netodiplom.ru."
    }

  # yandex_vpc_network.default will be created
  + resource "yandex_vpc_network" "default" {
      + created_at                = (known after apply)
      + default_security_group_id = (known after apply)
      + folder_id                 = (known after apply)
      + id                        = (known after apply)
      + labels                    = (known after apply)
      + name                      = "net"
      + subnet_ids                = (known after apply)
    }

  # yandex_vpc_route_table.nat-table will be created
  + resource "yandex_vpc_route_table" "nat-table" {
      + created_at = (known after apply)
      + folder_id  = (known after apply)
      + id         = (known after apply)
      + labels     = (known after apply)
      + name       = "everything-to-internal"
      + network_id = (known after apply)

      + static_route {
          + destination_prefix = "0.0.0.0/0"
          + next_hop_address   = "192.168.100.100"
        }
    }

  # yandex_vpc_subnet.subnet[0] will be created
  + resource "yandex_vpc_subnet" "subnet" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet-01"
      + network_id     = (known after apply)
      + route_table_id = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.100.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-a"
    }

  # yandex_vpc_subnet.subnet[1] will be created
  + resource "yandex_vpc_subnet" "subnet" {
      + created_at     = (known after apply)
      + folder_id      = (known after apply)
      + id             = (known after apply)
      + labels         = (known after apply)
      + name           = "subnet-02"
      + network_id     = (known after apply)
      + route_table_id = (known after apply)
      + v4_cidr_blocks = [
          + "192.168.200.0/24",
        ]
      + v6_cidr_blocks = (known after apply)
      + zone           = "ru-central1-b"
    }

Plan: 19 to add, 0 to change, 0 to destroy.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

yandex_dns_zone.default: Creating...
yandex_vpc_network.default: Creating...
3yandex_dns_zone.default: Creation complete after 3s [id=dns6lf2cv47trsklmfo1]
yandex_vpc_network.default: Creation complete after 3s [id=enpev25gdgr24i8bb83l]
yandex_vpc_route_table.nat-table: Creating...
yandex_vpc_route_table.nat-table: Creation complete after 1s [id=enpe77tlp7o02vo5srkg]
yandex_vpc_subnet.subnet[1]: Creating...
yandex_vpc_subnet.subnet[0]: Creating...
yandex_vpc_subnet.subnet[1]: Creation complete after 1s [id=e2lj13j0i41sc9p3g19b]
yandex_compute_instance.runner: Creating...
yandex_compute_instance.db02: Creating...
yandex_vpc_subnet.subnet[0]: Creation complete after 2s [id=e9b4bf804r58rm7mb99v]
yandex_compute_instance.monitoring: Creating...
yandex_compute_instance.app: Creating...
yandex_compute_instance.db01: Creating...
yandex_compute_instance.proxy: Creating...
yandex_compute_instance.gitlab: Creating...
yandex_compute_instance.runner: Still creating... [10s elapsed]
yandex_compute_instance.db02: Still creating... [10s elapsed]
yandex_compute_instance.monitoring: Still creating... [10s elapsed]
yandex_compute_instance.app: Still creating... [10s elapsed]
yandex_compute_instance.proxy: Still creating... [10s elapsed]
yandex_compute_instance.db01: Still creating... [10s elapsed]
yandex_compute_instance.gitlab: Still creating... [10s elapsed]
yandex_compute_instance.runner: Still creating... [20s elapsed]
yandex_compute_instance.db02: Still creating... [20s elapsed]
yandex_compute_instance.monitoring: Still creating... [20s elapsed]
yandex_compute_instance.app: Still creating... [20s elapsed]
yandex_compute_instance.proxy: Still creating... [20s elapsed]
yandex_compute_instance.db01: Still creating... [20s elapsed]
yandex_compute_instance.gitlab: Still creating... [20s elapsed]
yandex_compute_instance.db02: Creation complete after 25s [id=epdnsenbj1ppfqgannbs]
yandex_compute_instance.gitlab: Creation complete after 24s [id=fhm1lc3r9bjj2a7a44pb]
yandex_compute_instance.app: Creation complete after 24s [id=fhmus1uac0u22v9dd429]
yandex_compute_instance.proxy: Creation complete after 27s [id=fhmg8rd61r349aagpnl3]
yandex_dns_recordset.domains[1]: Creating...
yandex_dns_recordset.domains[0]: Creating...
yandex_dns_recordset.domains[4]: Creating...
yandex_dns_recordset.domains[5]: Creating...
yandex_dns_recordset.domains[3]: Creating...
yandex_dns_recordset.domains[2]: Creating...
yandex_dns_recordset.domains[3]: Creation complete after 0s [id=dns6lf2cv47trsklmfo1/grafana/A]
yandex_compute_instance.monitoring: Creation complete after 27s [id=fhmlsvvhe01jabc7fg60]
yandex_dns_recordset.domains[1]: Creation complete after 0s [id=dns6lf2cv47trsklmfo1/www/A]
yandex_dns_recordset.domains[2]: Creation complete after 1s [id=dns6lf2cv47trsklmfo1/gitlab/A]
yandex_dns_recordset.domains[4]: Creation complete after 1s [id=dns6lf2cv47trsklmfo1/prometheus/A]
yandex_compute_instance.db01: Creation complete after 28s [id=fhmle8m7mvn840git3hs]
yandex_dns_recordset.domains[5]: Creation complete after 1s [id=dns6lf2cv47trsklmfo1/alertmanager/A]
yandex_dns_recordset.domains[0]: Creation complete after 1s [id=dns6lf2cv47trsklmfo1/@/A]
yandex_compute_instance.runner: Creation complete after 30s [id=epdhd6vakld4ut6l76ve]
local_file.inventory: Creating...
local_file.inventory: Creation complete after 0s [id=f69fb1515e0f707a08d112ff9e8d34071f7511e9]

Apply complete! Resources: 19 added, 0 changed, 0 destroyed.
````

Результат в консоли YC
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-20%20015817.png)

3.  Настроить внешний Reverse Proxy на основе Nginx и LetsEncrypt.

1.  Создадим конф. файлы terraform для машин укаказанных в задании
2. С помощью terraform(dns.tf) создадим записи в днс
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20014811.png)
3. Мы будем использовать готовую роль(https://github.com/geerlingguy/ansible-role-certbot/) для установки nginx и настройки Lets Encrypt, дополнительно нам понадобится https://galaxy.ansible.com/ansible/posix
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20014646.png)

Выпущенный сертификат:

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20020633.png)

4. Установка кластера MySQL
Результаты:
MySQL работает в режиме репликации Master/Slave.
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20021915.png)
В кластере автоматически создаётся база данных c именем wordpress.
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20022607.png)
В кластере автоматически создаётся пользователь wordpress с полными правами на базу wordpress и паролем wordpress
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20022834.png)

5.  Установка WordPress
Установлен nginx
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20232337.png)
Установлен wordpress
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20232438.png)

Настроена А-запись.
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20232636.png)

Главная страница открывается по заданному URL
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20232717.png)

6. Установка Gitlab CE и Gitlab Runner
После исполнения роли Gitlab доступен

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-23%20000503.png)

Добавляем раннер, взяв ключ из консоли gitlab

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-23%20005907.png)

Для настройки пайпа необходимо прописать ssh ключ
![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-23%20001336.png)

Задача выполняемая при коммите с тегом и без тега
![](https://github.com/Nonstopus/diplom/blob/main/img/without_tag.png)

![](https://github.com/Nonstopus/diplom/blob/main/img/jobs_with_tag.png)

7.Установка Prometheus, Alert Manager, Node Exporter и Grafana:

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-23%20021750.png)

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-23%20022955.png)

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-23%20022019.png)

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-23%20022214.png)

![](https://github.com/Nonstopus/diplom/blob/main/img/%D0%A1%D0%BD%D0%B8%D0%BC%D0%BE%D0%BA%20%D1%8D%D0%BA%D1%80%D0%B0%D0%BD%D0%B0%202022-10-22%20232636.png)

