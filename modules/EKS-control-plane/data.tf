data "tls_certificate" "example" {
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}


