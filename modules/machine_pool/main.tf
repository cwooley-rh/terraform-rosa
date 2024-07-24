variable "cluster_id" {}
variable "name" {}
variable "machine_type" {}
variable "replicas" {}
variable "labels" { type = map(string) }
variable "taints" { type = map(string) }

resource "rhcs_machine_pool" "this" {
  cluster      = var.cluster_id
  name         = var.name
  machine_type = var.machine_type
  replicas     = var.replicas
  labels       = var.labels
  taints       = var.taints
}