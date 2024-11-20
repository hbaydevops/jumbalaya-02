## Terraform block
terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
}

locals {
  aws_region         = "us-east-2"
  control_plane_name = "dev-jurist-blueops-control-plane"
  user_arn = "arn:aws:iam::713881795316:role/dev-jurist-blueops-eks-control-plane-role"
  common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}

module "aws-auth-config" {
  source             = "../../modules/aws-auth-config"
  aws_region         = local.aws_region
  user_arn = local.user_arn
  control_plane_name = local.control_plane_name
  common_tags = local.common_tags
}