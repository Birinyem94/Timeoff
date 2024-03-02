# Create AWS EKS Node Group 

resource "aws_eks_node_group" "eks_ng" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-eks_ng"
  node_role_arn   = aws_eks_node_group.eks_ng.arn
  subnet_ids      = data.aws_subnet.Private.id

  ami_type       = var.ami_type
  disk_size      = var.disk_size
  instance_types = var.instance_types

  scaling_config {
    desired_size = var.des_size
    max_size     = var.max_size
    min_size     = var.min_size
  }

  /* remote_access {
    source_security_group_ids = [aws_security_group.eks_node_group_sg.id]
  } */

  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = "Node-Group"
  }
}




