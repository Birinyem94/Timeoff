################################################################################
# aws-auth configmap
################################################################################

locals {
  aws_auth_roles = concat(
    [
      {
        rolearn  = aws_iam_role.node-group-role.arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      },
    ],
    var.eks_roles
  )
}

resource "kubectl_manifest" "aws_auth" {
  yaml_body = <<YAML
apiVersion: v1
kind: ConfigMap
metadata:
  labels:
    app.kubernetes.io/managed-by: Terraform
  name: aws-auth
  namespace: kube-system
data:
  mapAccounts: |
    []
  mapRoles: |
    ${indent(4, yamlencode(local.aws_auth_roles))}
  mapUsers: |
    []
YAML

  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
}

provider "kubectl" {
  config_path = "~/.kube/config"  # Path to your kubeconfig file
  host    = "https://F1697F28505A48E917CC77D717CD70DE.gr7.us-east-1.eks.amazonaws.com"   # Replace with your Kubernetes host
}