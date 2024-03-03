
# Create AWS EKS Node Group 
resource "aws_eks_node_group" "eks_ng" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-node"
  node_role_arn   = aws_iam_role.node-group-role.arn
  subnet_ids      = [for subnet in data.aws_subnet.private : subnet.id]

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
    aws_eks_cluster.eks_cluster,
    aws_iam_role_policy_attachment.node-EKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.node-EKS_CNI_Policy,
    aws_iam_role_policy_attachment.node-AmazonEBSCSIDriverPolicy,
    aws_iam_role_policy_attachment.node-EC2ContainerRegistryReadOnly,
  ]

  tags = {
    Name = "Node-Group"
  }
}

## Then we need to attach AmazonEKSClusterPolicy to this role.

### EKS NodeGroup

# create an IAM role for EKS

resource "aws_iam_role" "eks-cluster-role" {
  name = "eks-cluster-${var.cluster_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}


## Then we need to attach AmazonEKSClusterPolicy to this role.

resource "aws_iam_role_policy_attachment" "amazon-eks-cluster-policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role.name
}

### EKS NodeGroup

resource "aws_iam_role" "node-group-role" {
  name = "node-group-${var.cluster_name}"


  assume_role_policy = jsonencode({
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "eks.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      },
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ],
    "Version": "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "node-EKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "node-EKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.node-group-role.name
}

resource "aws_iam_role_policy_attachment" "node-EC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.node-group-role.name
}

# Needed by the aws-ebs-csi-driver 
resource "aws_iam_role_policy_attachment" "node-AmazonEBSCSIDriverPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
  role       = aws_iam_role.node-group-role.name
}