data "template_file" "cloud_init" {
  template = file("cloud-init.tmpl.yaml")
  vars = {
    user = var.user
    ssh_key = file(var.public_key_path)
  }
}

resource "yandex_compute_instance" "openvpn" {
  name = "openvpn"
  folder_id = var.folder_id
  platform_id = "standard-v2"
  zone = "ru-central1-a"

  resources {
    cores = 4
    memory = 4

  }
  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = "fd80o2eikcn22b229tsa"
      type = "network-ssd"
      size = 100
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.test-vpc-subpet.id
    nat = true
  }

  metadata = {
    user-data = data.template_file.cloud_init.rendered
    serial-port-enable = 1
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${var.user}:${var.xrdp_password}' | sudo chpasswd",
      "sudo apt-get update",
      "sudo docker run --cap-add=NET_ADMIN -it -p 1194:1194/udp -p 80:8080/tcp -e HOST_ADDR=$(curl -s https://api.ipify.org) alekslitvinenk/openvpn"
    ]
    connection {
      type = "ssh"
      user = var.user
      private_key = file(var.private_key_path)
      host = self.network_interface[0].nat_ip_address
    }
  }

  timeouts {
    create = "10m"
  }
}

