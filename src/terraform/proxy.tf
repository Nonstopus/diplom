resource "yandex_compute_instance" "proxy" {
  name                      = "proxy"
  hostname                  = "proxy"
  zone                      = var.zones[0]
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = "10"
      type = "network-nvme"
      name = "root-proxy"
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id      = yandex_vpc_subnet.subnet[0].id
    ip_address     = "192.168.100.100"
    nat            = true
    nat_ip_address = var.static_ip
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}