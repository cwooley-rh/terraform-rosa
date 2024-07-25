#version of OCP to use
ocp_version  = "4.16.2"

cluster_name = "cwooley-test"
# number of replicas for the default machine pool
replicas = 3
# whether to create account roles
create_account_roles = true 
# Whether to create OIDC configuration
create_oidc = true

private = false
multi_az = false
# Password for the developer user
developer_password = ""

# AWS region where the ROSA cluster and components will be provisioned
region = "us-east-2"

#default machine pool instance type
compute_machine_type = "p3.2xlarge"

# Name of the secondary machine pool
secondary_machine_pool_name = "secondary-pool"

# Instance type for the secondary machine pool
secondary_machine_pool_instance_type = "m5.xlarge"

# Number of replicas for the secondary machine pool
secondary_machine_pool_replicas = 2

# List of S3 bucket names to create
bucket_names = ["my-cluster-bucket1", "my-cluster-bucket2"]
