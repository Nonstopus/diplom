resource "yandex_compute_instance" "gitlab" {
  name                      = "gitlab"
  hostname                  = "gitlab"
  zone                      = var.zones[0]
  allow_stopping_for_update = true

  resources {
    cores  = 4
    memory = 10
    core_fraction = var.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id    = var.image_id
      size        = "10"
    }
  }

  scheduling_policy {
    preemptible = var.preemptible
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet[0].id
    nat       = false
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }
}