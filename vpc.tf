resource "yandex_vpc_network" "test-vpc" {
  name = "minky"
}

resource "yandex_vpc_subnet" "test-vpc-subpet" {
  v4_cidr_blocks = ["10.2.0.0/16"]
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.test-vpc.id}"
}
