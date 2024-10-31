aws_region    = "us-east-2"
instance_type = "t2.medium"
volume_size = 30


common_tags = {
  "id"             = "2024"
  "name"           = "blueops-ec2"
  "owner"          = "jurist"
  "environment"    = "dev"
  "project"        = "blueops"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
  "company"        = "DEL"
}