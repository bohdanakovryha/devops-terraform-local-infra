Terraform configuration that creates a local infrastructure in Docker:

| Part | Resources |
|---|---|
| Web services | 3 Nginx containers `web-1`, `web-2`, `web-3` on ports 8081, 8082, 8083 |
| Object storage | MinIO container (API 9000, console 9001) and buckets `student-bucket-1`, `student-bucket-2` |
| Application | Nginx `8080:80` and PostgreSQL `5432:5432` (database, user and password from variables) |
| Kubernetes | kind cluster `student-cluster`: 1 control-plane, 2 `medium` workers, 2 `large` workers |
| Network | `public-network` 172.20.0.0/24 and internal `private-network` 172.21.0.0/24 |

## Files

```
versions.tf       Terraform and provider versions
providers.tf      docker, minio and kind providers
variables.tf      input variables
terraform.tfvars  PostgreSQL database name, user and password
network.tf        public and private Docker networks
images.tf         Docker images
web.tf            three Nginx web services
minio.tf          MinIO container and buckets
app.tf            Nginx, PostgreSQL and a test container in the private network
kind.tf           kind Kubernetes cluster
outputs.tf        outputs
```

## Requirements

- Terraform >= 1.5
- Docker Desktop (running)
- kubectl (for checking the cluster)

On Linux or macOS set the Docker socket:

```bash
export TF_VAR_docker_host="unix:///var/run/docker.sock"
```

## Usage

```bash
terraform init
terraform fmt
terraform validate
terraform plan
terraform apply
```

## Checks

```bash
docker ps
curl http://localhost:8081
curl http://localhost:8082
curl http://localhost:8083
curl http://localhost:8080
docker exec postgres psql -U student -d student_db -c "\conninfo"
docker exec minio mc alias set local http://localhost:9000 minioadmin minioadmin123
docker exec minio mc ls local
docker network ls
docker network inspect private-network
docker run --rm --network private-network alpine ping -c 2 -W 2 8.8.8.8
kubectl --kubeconfig kubeconfig get nodes -L node-type
terraform output
```

MinIO console: http://localhost:9001 (user `minioadmin`, password `minioadmin123`).

## Cleanup

```bash
terraform destroy
```
