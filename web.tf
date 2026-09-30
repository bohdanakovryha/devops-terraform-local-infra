resource "docker_container" "web" {
  count = length(var.web_ports)

  name  = "web-${count.index + 1}"
  image = docker_image.nginx.image_id

  ports {
    internal = 80
    external = var.web_ports[count.index]
  }

  networks_advanced {
    name         = docker_network.public.name
    ipv4_address = "172.20.0.${11 + count.index}"
  }

  upload {
    file    = "/usr/share/nginx/html/index.html"
    content = "<h1>Web service ${count.index + 1}</h1><p>Port ${var.web_ports[count.index]}</p>\n"
  }
}
