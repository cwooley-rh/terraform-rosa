resource "rhcs_cluster_rosa_classic" "rosa" {
  name               = var.name
  cloud_region       = var.cloud_region
  aws_account_id     = var.aws_account_id
  availability_zones = var.availability_zones
  properties = {
    rosa_creator_arn = var.rosa_creator_arn
  }
  sts = {
    operator_role_prefix = var.operator_role_prefix
    role_arn             = var.role_arn
    support_role_arn     = var.support_role_arn
    instance_iam_roles = {
      master_role_arn = var.master_role_arn
      worker_role_arn = var.worker_role_arn
    }
  }
}

variable "name" {}
variable "cloud_region" {}
variable "aws_account_id" {}
variable "availability_zones" { type = list(string) }
variable "rosa_creator_arn" {}
variable "operator_role_prefix" {}
variable "role_arn" {}
variable "support_role_arn" {}
variable "master_role_arn" {}
variable "worker_role_arn" {}