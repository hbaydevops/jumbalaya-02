aws_region_main   = "us-east-2"
aws_region_backup = "us-east-1"
force_destroy     = true

common_tags = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "demo-project"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }