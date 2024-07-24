terraform {
  required_providers {
    rhcs = {
      source  = "terraform-redhat/rhcs"
      version = ">= 1.1.0"
    }
  }
}

provider "rhcs" {}

module "rosa_cluster" {
  source              = "./modules/rosa_cluster"
  name                = var.cluster_name
  cloud_region        = var.cloud_region
  aws_account_id      = var.aws_account_id
  availability_zones  = var.availability_zones
  rosa_creator_arn    = var.rosa_creator_arn
  operator_role_prefix = var.operator_role_prefix
  role_arn            = var.role_arn
  support_role_arn    = var.support_role_arn
  master_role_arn     = var.master_role_arn
  worker_role_arn     = var.worker_role_arn
}

module "default_machine_pool" {
  source      = "./modules/machine_pool"
  cluster_id  = module.rosa_cluster.id
  name        = "default-pool"
  machine_type = var.compute_machine_type
  replicas    = var.default_replicas
}

module "secondary_machine_pool" {
  source      = "./modules/machine_pool"
  cluster_id  = module.rosa_cluster.id
  name        = var.secondary_pool_name
  machine_type = var.secondary_machine_type
  replicas    = var.secondary_replicas
  labels      = var.secondary_labels
  taints      = var.secondary_taints
}