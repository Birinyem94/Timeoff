cluster_name                         = "ekspro"
cluster_service_ipv4_cidr            = "172.20.0.0/16"
cluster_version                      = "1.28"
cluster_endpoint_private_access      = false
cluster_endpoint_public_access       = true
cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
des_size                             = 1
min_size                             = 1
max_size                             = 2
ami_type                             = "AL2_x86_64"
disk_size                            = 20
instance_types                       = ["t3.medium"]

eks_roles = [
  {
    role_arn = "arn:aws:iam::891377060995:role/node-group-ekspro"
    username = "system:node:<EC2PrivateDNSName>"
    groups   = ["system:bootstrappers", "system:nodes"]
  }
]