variable "region" {
  description = "The AWS region to provision a ROSA cluster and required components into."
  type = string
  default = "us-east-1"
}

variable "token" {
  description = "OCM token used to authenticate against the OpenShift Cluster Manager API."
  type = string
  sensitive = true
}

variable "cluster_name" {
  description = "The name of the cluster."
  type = string
}

variable "openshift_version" {
  description = "The version of OpenShift to use."
  type = string
}

variable "machine_cidr" {
  description = "The CIDR of the VPC that will be created."
  type = string
}

variable "aws_subnet_ids" {
  description = "List of subnet IDs."
  type = list(string)
}

variable "aws_availability_zones" {
  description = "List of availability zones."
  type = list(string)
}

variable "replicas" {
  description = "Number of replicas for the default machine pool."
  type = number
}

variable "create_account_roles" {
  description = "Whether to create account roles."
  type = bool
}

variable "account_role_prefix" {
  description = "Prefix for account roles."
  type = string
}

variable "create_oidc" {
  description = "Whether to create OIDC configuration."
  type = bool
}

variable "create_operator_roles" {
  description = "Whether to create operator roles."
  type = bool
}

variable "operator_role_prefix" {
  description = "Prefix for operator roles."
  type = string
}

variable "tags" {
  description = "Tags applied to all objects."
  type = map(string)
  default = {}
}

variable "admin_password" {
  description = "Password for the admin user"
  type        = string
  sensitive   = true
}

variable "developer_password" {
  description = "Password for the developer user"
  type        = string
  sensitive   = true
}

variable "bucket_names" {
  description = "List of S3 bucket names to create."
  type        = list(string)
  default     = ["bucket1", "bucket2"]
}

variable "secondary_machine_pool_name" {
  description = "Name of the secondary machine pool."
  type        = string
  default     = "secondary-pool"
}

variable "secondary_machine_pool_instance_type" {
  description = "Instance type for the secondary machine pool."
  type        = string
  default     = "m5.large"
}

variable "secondary_machine_pool_replicas" {
  description = "Number of replicas for the secondary machine pool."
  type        = number
  default     = 2
}