resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }
  data = {
    mapRoles = jsonencode([
      {
        rolearn  = var.role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      }
    ])
    mapUsers = jsonencode([
      {
        "userarn" : var.user_arn,
        "username": var.username,
        "groups"  : ["system:masters"]
      }
    ])
  }
  
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  token                  = data.aws_eks_cluster_auth.eks.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
}

# resource "kubernetes_cluster_role_binding" "eks_admin" {
#   metadata {
#     name = "eks-admin"
#   }

#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "ClusterRole"
#     name      = "cluster-admin"
#   }

#   subject {
#     kind      = "User"
#     name      = "root"
#     api_group = "rbac.authorization.k8s.io"
#   }
# }

