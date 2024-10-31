aws_region   = "us-east-2"
source_instance_id = data.aws_instance.existing_instance.id




common_tags = {
    "id"             = "2024"
    "name"             = "blueops-ami"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company" = "DEL"
  }