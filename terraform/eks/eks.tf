# Create AWS EKS Cluster

resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  version  = var.cluster_version
  role_arn = aws_iam_role.node-group-role.arn

  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
    subnet_ids              = [for subnet in data.aws_subnet.private : subnet.id]
    security_group_ids      = [aws_security_group.eks_cluster_sg.id]
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  depends_on = [
    aws_iam_role_policy_attachment.amazon-eks-cluster-policy,

  ]

}
