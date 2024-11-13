

variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_version" {
  type = string
}

variable "endpoint_private_access" {
  type = bool
}

variable "endpoint_public_access" {
  type = bool
}

variable "public_subnets" {
  type = map(string)
  default = {
    us-east-2a = "subnet-0ebbd1751fb00c957"
    us-east-2b = "subnet-0ffe054defef01d13"
    us-east-2c = "subnet-0306d57d9ddb7b080"
  }
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "name"           = "demo-project-cluster"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}
