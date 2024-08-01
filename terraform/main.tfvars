cluster_name = "cwooley-rhoai"
region = "us-east-2"
compute_machine_type = "p3.2xlarge"
private = false
hosted_control_plane = true
bucket_count = 2
bucket_names = ["og-model-store", "resultant-artifact"]
secondary_machinepool_type = "m5.xlarge"