output "web_services" {
  description = "URLs of the three Nginx web services"
  value       = [for port in var.web_ports : "http://localhost:${port}"]
}

output "nginx_url" {
  description = "URL of the Nginx container"
  value       = "http://localhost:8080"
}

output "postgres_connection" {
  description = "PostgreSQL connection string without password"
  value       = "postgresql://${var.postgres_user}@localhost:5432/${var.postgres_db}"
}

output "minio_console" {
  description = "MinIO web console"
  value       = "http://localhost:${var.minio_console_port}"
}

output "minio_buckets" {
  description = "Created MinIO buckets"
  value       = sort([for b in minio_s3_bucket.buckets : b.bucket])
}

output "networks" {
  description = "Docker networks and their subnets"
  value = {
    (docker_network.public.name)  = "172.20.0.0/24"
    (docker_network.private.name) = "172.21.0.0/24 (internal)"
  }
}

output "kubeconfig_path" {
  description = "Path to kubeconfig of the kind cluster"
  value       = kind_cluster.cluster.kubeconfig_path
}

output "kind_worker_groups" {
  description = "Worker node groups of the kind cluster"
  value       = var.worker_groups
}
