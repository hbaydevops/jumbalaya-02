data "aws_eks_cluster_auth" "eks" {
  name = var.control_plane_name
}