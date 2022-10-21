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
