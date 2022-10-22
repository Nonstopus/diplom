resource "yandex_compute_instance" "app" {
  name                      = "app"
  hostname                  = "app"
  zone                      = var.zones[0]
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 4
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = "10"
    }
  }

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[0].id
    nat       = false
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}