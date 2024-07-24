terraform {
  required_providers {
    rhcs = {
      source  = "terraform-redhat/rhcs"
      version = ">= 1.1.0"
    }
  }
}

provider "rhcs" {
  token = var.token
}

data "aws_caller_identity" "current" {}

module "rosa_cluster" {
  source              = "./modules/rosa_cluster"
  cluster_name        = var.cluster_name
  region              = var.region
  aws_account_id      = data.aws_caller_identity.current.account_id
  tags                = var.tags
  autoscaling         = var.autoscaling
  replicas            = var.replicas
  private             = var.private
  aws_subnet_ids      = module.network.subnet_ids  # Assuming you have a network module
  vpc_cidr            = var.vpc_cidr
  availability_zones  = module.network.availability_zones  # Assuming you have a network module
  multi_az            = var.multi_az
  pod_cidr            = var.pod_cidr
  service_cidr        = var.service_cidr
  compute_machine_type = var.compute_machine_type
  ocp_version         = var.ocp_version
  sts_roles           = module.sts_roles.roles  # Assuming you have an STS roles module
  rosa_creator_arn    = data.aws_caller_identity.current.arn
  hosted_control_plane = var.hosted_control_plane
}

module "default_machine_pool" {
  source      = "./modules/machine_pool"
  cluster_id  = module.rosa_cluster.cluster_id
  name        = "default-pool"
  machine_type = var.compute_machine_type
  replicas    = var.replicas
}

module "secondary_machine_pool" {
  source      = "./modules/machine_pool"
  cluster_id  = module.rosa_cluster.cluster_id
  name        = var.secondary_pool_name
  machine_type = var.secondary_machine_type
  replicas    = var.secondary_replicas
  labels      = var.secondary_labels
  taints      = var.secondary_taints
}