resource "yandex_dns_zone" "default" {
  name        = "my-private-zone"
  description = "desc"

  labels = {
    label1 = "label-1-public"
  }

  zone    = "netodiplom.ru."
  public  = true
}

resource "yandex_dns_recordset" "domains" {
  count = 6
  zone_id = yandex_dns_zone.default.id
  name = var.sub_domain[count.index]
  type = "A"
  ttl = 600
  data    = [yandex_compute_instance.proxy.network_interface[0].nat_ip_address]
  depends_on = [yandex_compute_instance.proxy]
}