resource "rhcs_machine_pool" "this" {
  cluster      = var.cluster_id
  name         = var.name
  machine_type = var.machine_type
  replicas     = var.replicas
  labels       = var.labels
  taints       = var.taints
}