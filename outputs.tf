output "vpc_id" {
  value = module.network.vpc_id
}

output "vpc_cidr" {
  value = module.network.vpc_cidr
}

output "public_subnet_ids" {
  value = module.network.public_subnet_ids
}

output "private_subnet_ids" {
  value = module.network.private_subnet_ids
}

output "public_subnet_azs" {
  value = module.network.public_subnet_azs
}

output "private_subnet_azs" {
  value = module.network.private_subnet_azs
}

output "private_route_table_ids" {
  value = module.network.private_route_table_ids
}

output "oidc_config_id" {
  value = module.rosa_cluster.cluster_oidc_config_id
}

output "oidc_endpoint_url" {
  value = module.rosa_cluster.cluster_oidc_endpoint_url
}

output "cluster_api_url" {
  value = module.rosa_cluster.cluster_api_url
}

output "cluster_console_url" {
  value = module.rosa_cluster.cluster_console_url
}

output "s3_bucket_name" {
  description = "The name of the created S3 bucket"
  value       = aws_s3_bucket.model-store.id
}