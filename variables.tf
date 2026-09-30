variable "docker_host" {
  description = "Docker daemon address (Windows: npipe, Linux/macOS: unix socket)"
  type        = string
  default     = "npipe:////./pipe/docker_engine"
}

variable "web_ports" {
  description = "Host ports for the three Nginx web services"
  type        = list(number)
  default     = [8081, 8082, 8083]
}

variable "minio_root_user" {
  description = "MinIO root user"
  type        = string
  default     = "minioadmin"
}

variable "minio_root_password" {
  description = "MinIO root password"
  type        = string
  sensitive   = true
  default     = "minioadmin123"
}

variable "minio_api_port" {
  description = "Host port for the MinIO S3 API"
  type        = number
  default     = 9000
}

variable "minio_console_port" {
  description = "Host port for the MinIO web console"
  type        = number
  default     = 9001
}

variable "bucket_names" {
  description = "MinIO buckets to create"
  type        = set(string)
  default     = ["student-bucket-1", "student-bucket-2"]
}

variable "postgres_db" {
  description = "PostgreSQL database name"
  type        = string
}

variable "postgres_user" {
  description = "PostgreSQL user"
  type        = string
}

variable "postgres_password" {
  description = "PostgreSQL password"
  type        = string
  sensitive   = true
}

variable "cluster_name" {
  description = "Name of the kind Kubernetes cluster"
  type        = string
  default     = "student-cluster"
}

variable "worker_groups" {
  description = "Number of kind worker nodes in each group"
  type        = map(number)
  default = {
    medium = 2
    large  = 2
  }
}
