output "cluster_id" {
  value = module.hcp.cluster_id
}

output "cluster_api_url" {
  value = module.hcp.cluster_api_url
}

output "cluster_console_url" {
  value = module.hcp.cluster_console_url
}

output "bucket_names" {
  value = [for bucket in aws_s3_bucket.buckets : bucket.bucket]
}

output "secondary_machine_pool_name" {
  value = rhcs_machine_pool.secondary_pool.name
}

output "secondary_machine_pool_instance_type" {
  value = rhcs_machine_pool.secondary_pool.instance_type
}

output "secondary_machine_pool_replicas" {
  value = rhcs_machine_pool.secondary_pool.replicas
}