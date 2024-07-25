resource "rhcs_cluster_rosa_classic" "this" {
  count = var.hosted_control_plane ? 0 : 1

  name = var.name

  cloud_region   = var.cloud_region
  aws_account_id = var.aws_account_id
  tags           = var.tags

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
  count = var.hosted_control_plane ? 1 : 0

  name = var.name

  cloud_region           = var.cloud_region
  aws_account_id         = var.aws_account_id
  aws_billing_account_id = var.aws_account_id
  tags                   = var.tags

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

locals {
  cluster_id                = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].id : rhcs_cluster_rosa_classic.this[0].id
  cluster_name              = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].name : rhcs_cluster_rosa_classic.this[0].name
  cluster_oidc_config_id    = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].sts.oidc_config_id : rhcs_cluster_rosa_classic.this[0].sts.oidc_endpoint_url
  cluster_oidc_endpoint_url = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].sts.oidc_config_id : rhcs_cluster_rosa_classic.this[0].sts.oidc_endpoint_url
  cluster_api_url           = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].api_url : rhcs_cluster_rosa_classic.this[0].api_url
  cluster_console_url       = var.hosted_control_plane ? rhcs_cluster_rosa_hcp.this[0].console_url : rhcs_cluster_rosa_classic.this[0].console_url
}