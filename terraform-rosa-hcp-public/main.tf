terraform {
  required_providers {
    rhcs = {
      source  = "terraform-redhat/rhcs"
      version = ">=0.1.0"
    }
  }
}

module "hcp" {
  source = "terraform-redhat/rosa-hcp/rhcs"
  version = "1.6.2"

  cluster_name = var.cluster_name
  openshift_version = var.ocp_version
  aws_subnet_ids = var.aws_subnet_ids
  aws_availability_zones = var.aws_availability_zones
  replicas = var.replicas
  pod_cidr             = "10.128.0.0/14"
  service_cidr         = "172.30.0.0/16"
  create_account_roles = var.create_account_roles
  create_operator_roles = var.create_operator_roles
  operator_role_prefix = var.operator_role_prefix

  private = false
  tags = var.tags
}

resource "aws_s3_bucket" "buckets" {
  for_each = toset(var.bucket_names)

  bucket = each.key

  tags = {
    Name        = each.key
    Environment = "Production"
  }
}


resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.example.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [aws_s3_bucket_ownership_controls.example]

  bucket = aws_s3_bucket.example.id
  acl    = "private"  # or "public-read", etc.
}

resource "rhcs_machine_pool" "secondary_pool" {
  cluster      = module.hcp.cluster_id
  name         = var.secondary_machine_pool_name
  machine_type = var.secondary_machine_pool_instance_type
  replicas     = var.secondary_machine_pool_replicas

  labels = {
    role = "worker"
  }

  taints = [
    {
      key    = "dedicated"
      value  = "worker"
      effect = "NoSchedule"
    }
  ]
}

resource "rhcs_identity_provider" "htpasswd_idp" {
  cluster = module.hcp.cluster_id
  name    = "htpasswd"
  htpasswd = {
    users = [
      {
        username = "admin"
        password = var.admin_password
      },
      {
        username = "developer"
        password = var.developer_password
      }
    ]
  }
}
