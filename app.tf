resource "docker_container" "nginx" {
  name  = "nginx"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = 8080
  }

  networks_advanced {
    name         = docker_network.public.name
    ipv4_address = "172.20.0.10"
  }

  networks_advanced {
    name         = docker_network.private.name
    ipv4_address = "172.21.0.10"
  }
}

resource "docker_container" "postgres" {
  name  = "postgres"
  image = docker_image.postgres.image_id

  env = [
    "POSTGRES_DB=${var.postgres_db}",
    "POSTGRES_USER=${var.postgres_user}",
    "POSTGRES_PASSWORD=${var.postgres_password}",
  ]

  ports {
    internal = 5432
    external = 5432
  }

  networks_advanced {
    name         = docker_network.public.name
    ipv4_address = "172.20.0.20"
  }

  networks_advanced {
    name         = docker_network.private.name
    ipv4_address = "172.21.0.20"
  }

  healthcheck {
    test     = ["CMD-SHELL", "pg_isready -U ${var.postgres_user} -d ${var.postgres_db}"]
    interval = "5s"
    timeout  = "5s"
    retries  = 10
  }
}

resource "docker_container" "private_app" {
  name    = "private-app"
  image   = docker_image.nginx.image_id
  restart = "unless-stopped"

  networks_advanced {
    name         = docker_network.private.name
    ipv4_address = "172.21.0.30"
  }
}
