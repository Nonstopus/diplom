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
