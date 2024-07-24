variable "name" {}
variable "cloud_region" {}
variable "aws_account_id" {}
variable "tags" { type = map(string) }
variable "autoscaling" { default = false }
variable "autoscaling_min" { default = 2 }
variable "autoscaling_max" { default = 4 }
variable "replicas" { default = 2 }
variable "private" { default = false }
variable "aws_subnet_ids" { type = list(string) }
variable "vpc_cidr" {}
variable "availability_zones" { type = list(string) }
variable "multi_az" { default = false }
variable "pod_cidr" {}
variable "service_cidr" {}
variable "compute_machine_type" {}
variable "ocp_version" {}
variable "sts_roles" { type = map(string) }
variable "rosa_creator_arn" {}

resource "rhcs_cluster_rosa_classic" "this" {
  name               = var.name
  cloud_region       = var.cloud_region
  aws_account_id     = var.aws_account_id
  tags               = var.tags

  autoscaling_enabled = var.autoscaling
  min_replicas        = var.autoscaling ? var.autoscaling_min : null
  max_replicas        = var.autoscaling ? var.autoscaling_max : null
  replicas            = var.autoscaling ? null : var.replicas

  private            = var.private
  aws_private_link   = var.private
  aws_subnet_ids     = var.aws_subnet_ids
  machine_cidr       = var.vpc_cidr
  availability_zones = var.availability_zones
  multi_az           = var.multi_az
  pod_cidr           = var.pod_cidr
  service_cidr       = var.service_cidr

  compute_machine_type = var.compute_machine_type

  properties = { rosa_creator_arn = var.rosa_creator_arn }
  version    = var.ocp_version
  sts        = var.sts_roles

  disable_waiting_in_destroy = false
  wait_for_create_complete   = true
}

resource "rhcs_cluster_rosa_hcp" "this" {
  name               = var.name
  cloud_region       = var.cloud_region
  aws_account_id     = var.aws_account_id
  aws_billing_account_id = var.aws_account_id
  tags               = var.tags

  private            = var.private
  aws_subnet_ids     = var.aws_subnet_ids
  machine_cidr       = var.vpc_cidr
  availability_zones = var.availability_zones
  pod_cidr           = var.pod_cidr
  service_cidr       = var.service_cidr

  properties = { rosa_creator_arn = var.rosa_creator_arn }
  version    = var.ocp_version
  sts        = var.sts_roles

  compute_machine_type = var.compute_machine_type
  replicas             = var.replicas

  disable_waiting_in_destroy          = false
  wait_for_create_complete            = true
  wait_for_std_compute_nodes_complete = true
}

output "cluster_id" {
  value = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].id : rhcs_cluster_rosa_classic.this[0].id
}

output "cluster_name" {
  value = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].name : rhcs_cluster_rosa_classic.this[0].name
}

output "cluster_api_url" {
  value = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].api_url : rhcs_cluster_rosa_classic.this[0].api_url
}

output "cluster_console_url" {
  value = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].console_url : rhcs_cluster_rosa_classic.this[0].console_url
}