terraform {
  required_providers {
    rhcs = {
      source  = "terraform-redhat/rhcs"
      version = ">= 1.1.0"
    }
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.20.0"
    }
  }
}

provider "rhcs" {
  token = var.token
}

provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}

locals {
  autoscaling_min  = var.multi_az ? 3 : 2
  autoscaling_max  = var.multi_az ? 6 : 4
  default_replicas = var.multi_az ? 3 : 2
  subnet_ids       = var.private ? module.network.private_subnet_ids : concat(module.network.private_subnet_ids, module.network.public_subnet_ids)
}

module "network" {
  source = "./modules/network"

  vpc_cidr           = var.vpc_cidr
  subnet_cidr_size   = var.subnet_cidr_size
  availability_zones = data.aws_availability_zones.available.names
  cluster_name       = var.cluster_name
  private            = var.private
  tags               = var.tags
}

module "iam_roles" {
  source = "./modules/iam_roles"

  hosted_control_plane = var.hosted_control_plane
  cluster_name         = var.cluster_name
  ocp_version          = var.ocp_version
  tags                 = var.tags
  aws_account_id       = data.aws_caller_identity.current.account_id
}

module "rosa_cluster" {
  source = "./modules/rosa_cluster"

  name                = var.cluster_name
  cloud_region        = var.region
  aws_account_id      = data.aws_caller_identity.current.account_id
  tags                = var.tags
  autoscaling         = var.autoscaling
  autoscaling_min     = local.autoscaling_min
  autoscaling_max     = local.autoscaling_max
  replicas            = coalesce(var.replicas, local.default_replicas)
  private             = var.private
  aws_subnet_ids      = local.subnet_ids
  vpc_cidr            = var.vpc_cidr
  availability_zones  = module.network.private_subnet_azs
  multi_az            = var.multi_az
  pod_cidr            = var.pod_cidr
  service_cidr        = var.service_cidr
  compute_machine_type = var.compute_machine_type
  ocp_version         = var.ocp_version
  sts_roles           = module.iam_roles.sts_roles
  rosa_creator_arn    = data.aws_caller_identity.current.arn
  hosted_control_plane = var.hosted_control_plane
}

module "default_machine_pool" {
  source = "./modules/machine_pool"

  cluster_id   = module.rosa_cluster.cluster_id
  name         = "default-pool"
  machine_type = var.compute_machine_type
  replicas     = var.replicas
}

module "secondary_machine_pool" {
  source = "./modules/machine_pool"

  cluster_id   = module.rosa_cluster.cluster_id
  name         = var.secondary_pool_name
  machine_type = var.secondary_machine_type
  replicas     = var.secondary_replicas
  labels       = var.secondary_labels
  taints       = var.secondary_taints
}

module "identity_provider" {
  source = "./modules/identity_provider"

  cluster_id         = module.rosa_cluster.cluster_id
  admin_password     = var.admin_password
  developer_password = var.developer_password
}

resource "aws_s3_bucket" "model-store" {
  bucket = var.model_bucket_name
  tags   = var.tags
}

data "aws_availability_zones" "available" {
  state = "available"
}