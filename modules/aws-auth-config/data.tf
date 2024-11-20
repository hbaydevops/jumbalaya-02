data "aws_eks_cluster_auth" "eks" {
  name = "dev-jurist-blueops-control-plane"
}

data "aws_eks_cluster" "eks" {
  name = "dev-jurist-blueops-control-plane"
}