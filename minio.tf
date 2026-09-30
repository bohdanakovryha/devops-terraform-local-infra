resource "docker_container" "minio" {
  name    = "minio"
  image   = docker_image.minio.image_id
  command = ["server", "/data", "--console-address", ":9001"]

  env = [
    "MINIO_ROOT_USER=${var.minio_root_user}",
    "MINIO_ROOT_PASSWORD=${var.minio_root_password}",
  ]

  ports {
    internal = 9000
    external = var.minio_api_port
  }

  ports {
    internal = 9001
    external = var.minio_console_port
  }

  networks_advanced {
    name         = docker_network.public.name
    ipv4_address = "172.20.0.30"
  }

  healthcheck {
    test     = ["CMD", "mc", "ready", "local"]
    interval = "5s"
    timeout  = "5s"
    retries  = 20
  }

  wait         = true
  wait_timeout = 120
}

resource "minio_s3_bucket" "buckets" {
  for_each = var.bucket_names

  bucket        = each.value
  acl           = "private"
  force_destroy = true

  depends_on = [docker_container.minio]
}
