output "cluster_id" {
  description = "EKS cluster ID"
  value       = aws_eks_cluster.eks.cluster_id
}

output "certificate-authority" {
  description = "Nested attribute containing certificate-authority-data for cluster."
  value       = aws_eks_cluster.eks.certificate_authority[0].data
}

output "cluster_endpoint" {
  description = "The endpoint for EKS Kubernetes API."
  value       = aws_eks_cluster.eks.endpoint
}

output "cluster_oidc_issuer_url" {
  description = "The URL on the EKS cluster OIDC Issuer"
  value       = aws_eks_cluster.eks.identity[0].oidc[0].issuer
}

output "cluster_arn" {
  description = "The Amazon Resource Name (ARN) of the cluster."
  value       = aws_eks_cluster.eks_cluster.arn
}
