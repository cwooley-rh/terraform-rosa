variable "name" {
  type = string
}

variable "cloud_region" {
  type = string
}

variable "aws_account_id" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "autoscaling" {
  type    = bool
  default = false
}

variable "autoscaling_min" {
  type    = number
  default = 2
}

variable "autoscaling_max" {
  type    = number
  default = 4
}

variable "replicas" {
  type    = number
  default = 2
}

variable "private" {
  type    = bool
  default = false
}

variable "aws_subnet_ids" {
  type = list(string)
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "multi_az" {
  type    = bool
  default = false
}

variable "pod_cidr" {
  type = string
}

variable "service_cidr" {
  type = string
}

variable "compute_machine_type" {
  type = string
}

variable "ocp_version" {
  type = string
}

variable "sts_roles" {
  type = map(string)
}

variable "rosa_creator_arn" {
  type = string
}

variable "hosted_control_plane" {
  type    = bool
  default = false
}