resource "docker_network" "public" {
  name   = "public-network"
  driver = "bridge"

  ipam_config {
    subnet  = "172.20.0.0/24"
    gateway = "172.20.0.1"
  }
}

resource "docker_network" "private" {
  name     = "private-network"
  driver   = "bridge"
  internal = true

  ipam_config {
    subnet  = "172.21.0.0/24"
    gateway = "172.21.0.1"
  }
}
