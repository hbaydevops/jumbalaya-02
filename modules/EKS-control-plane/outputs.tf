output "thumbprint_hash" {
  value = data.tls_certificate.openid.certificates.0.sha1_fingerprint
}

output "control_plane_name" {
  value = aws_eks_cluster.eks.name
}

