resource "rhcs_hcp_machine_pool" "secondary_machine_pool" {
    auto_repair = false
    autoscaling = {
      enabled = false
    }
    aws_node_pool = {
      instance_type = var.secondary_machinepool_type
      tags = var.tags
    }
    cluster = var.cluster_name
    name = var.secondary_machinepool_name
    subnet_id = 
}