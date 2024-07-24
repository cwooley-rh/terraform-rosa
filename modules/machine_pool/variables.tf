variable "cluster_id" {
  type = string
}

variable "name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "replicas" {
  type = number
}

variable "labels" {
  type = map(string)
  default = {}
}

variable "taints" {
  type = map(string)
  default = {}
}