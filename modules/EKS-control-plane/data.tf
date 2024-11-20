data "tls_certificate" "openid" {
  url = aws_eks_cluster.eks.identity.0.oidc.0.issuer
}
data "aws_iam_policy" "amazon_eks_cluster_policy" {
  name = "AmazonEKSClusterPolicy"
}


# Data source to find default public subnets in us-east-2a, 2b, and 2c
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

data "aws_eks_cluster_auth" "eks" {
    depends_on = [aws_eks_cluster.eks]
  name = "dev-jurist-blueops-control-plane"
}

data "aws_eks_cluster" "eks" {
    depends_on = [aws_eks_cluster.eks]
  name = "dev-jurist-blueops-control-plane"
}