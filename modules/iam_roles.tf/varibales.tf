variable "hosted_control_plane" {
  type    = bool
  default = false
}

variable "cluster_name" {
  type = string
}

variable "ocp_version" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "aws_account_id" {
  type = string
}