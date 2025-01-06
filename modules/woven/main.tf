terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.44.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}



data "local_file" "iamrole" {
  filename = "${path.module}/policy.json"
}

locals {
  policy = jsondecode(data.local_file.iamrole.content)
}

output "policy_statements" {
  value = [
    for i in local.policy["Statement"] : {
      effect    = i ["Effect"]
      actions   = i ["Action"]
      resources = i ["Resource"]
      condition = try(i["Condition"], null)
    }
  ]
}

