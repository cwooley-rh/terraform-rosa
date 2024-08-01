resource "rhcs_hcp_machine_pool" "secondary_machine_pool" {
    auto_repair = false
    autoscaling = {
      enabled = true
    }
    aws_node_pool = {
      instance_type = var.secondary_machinepool_type
      tags = var.tags
    }
    cluster = rhcs_cluster_rosa_hcp.rosa[0].id
    name = var.secondary_machinepool_name
    subnet_id = element(module.network.private_subnet_ids, 0)
}