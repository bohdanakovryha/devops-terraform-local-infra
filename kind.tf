locals {
  kubeconfig_path = abspath("${path.module}/kubeconfig")

  worker_nodes = flatten([
    for group, count in var.worker_groups : [
      for i in range(count) : group
    ]
  ])
}

resource "kind_cluster" "cluster" {
  name            = var.cluster_name
  wait_for_ready  = true
  kubeconfig_path = local.kubeconfig_path

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    node {
      role = "control-plane"
    }

    dynamic "node" {
      for_each = local.worker_nodes

      content {
        role = "worker"

        labels = {
          "node-type" = node.value
        }
      }
    }
  }

  depends_on = [
    docker_network.public,
    docker_network.private,
  ]
}
