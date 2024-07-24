variable "private" {
  type    = bool
  default = false
}

variable "region" {
  type    = string
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "hosted_control_plane" {
  type    = bool
  default = false
}

variable "autoscaling" {
  type    = bool
  default = true
  description = "Enable autoscaling for the default machine pool, this is ignored for HCP clusters"
}

variable "replicas" {
  type = number
  nullable = true
  default = null
  description = "Number of replicas for the default machine pool, this is ignored if autoscaling is enabled"
}

variable "cluster_name" {
  type = string
}

variable "ocp_version" {
  type    = string
}

variable "vpc_cidr" {
  type    = string
}

variable "pod_cidr" {
  type    = string
}

variable "service_cidr" {
  type    = string
}

variable "tags" {
  description = "Tags applied to all objects"
  type        = map(string)
}

variable "compute_machine_type" {
  description = "The machine type used by the initial worker nodes, for example, m5.xlarge."
  type        = string
}

variable "aws_account_id" {
  type = string
}

variable "aws_subnet_ids" {
  type = list(string)
}

variable "availability_zones" {
  type = list(string)
}

variable "sts_roles" {
  type = map(string)
}

variable "rosa_creator_arn" {
  type = string
}