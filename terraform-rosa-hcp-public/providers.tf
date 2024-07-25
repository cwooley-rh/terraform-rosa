provider "aws" {
  region = var.region
}

provider "rhcs" {
  token = var.token
}

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