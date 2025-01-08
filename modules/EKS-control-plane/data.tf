data "tls_certificate" "openid" {
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}
data "aws_iam_policy" "amazon_eks_cluster_policy" {
  name = "AmazonEKSClusterPolicy"
}
data "aws_iam_policy" "eks_vpc_resource_controller" {
  name = "AmazonEKSVPCResourceController"
}


data "aws_subnets" "default_public" {
  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }

  filter {
    name   = "availability-zone"
    values = ["us-east-2a", "us-east-2b", "us-east-2c"]
  }
}
