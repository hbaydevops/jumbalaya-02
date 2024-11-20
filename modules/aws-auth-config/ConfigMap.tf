resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = jsonencode([
      {
        rolearn  = aws_iam_role.eks_cluster.arn
        username = "eks-cluster-role"
        groups   = ["system:masters"]
      },
      {
        rolearn  = aws_iam_role.nodes.arn
        username = "worker-nodes"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])

    mapUsers = jsonencode([
      {
        userarn  = var.user_arn
        username = "admin-user"
        groups   = ["system:masters"]
      }
    ])
  }
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  token                  = data.aws_eks_cluster_auth.eks.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority.0.data)
}

resource "null_resource" "cluster-auth-apply" {
  triggers = {
    always_run = timestamp()
  }
  provisioner "local-exec" {
    command = "aws eks update-kubeconfig --name ${var.control_plane_name} --region ${var.aws_region} --alias ${var.control_plane_name}"
  }

}
