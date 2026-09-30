provider "docker" {
  host = var.docker_host
}

provider "minio" {
  minio_server   = "127.0.0.1:${var.minio_api_port}"
  minio_user     = var.minio_root_user
  minio_password = var.minio_root_password
  minio_ssl      = false
}

provider "kind" {}
