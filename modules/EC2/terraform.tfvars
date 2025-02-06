aws_region    = "us-east-1"
instance_type = "t2.medium"
volume_size = 30


common_tags = {
  "id"             = "2025"
  "name"           = "jumbalaya-ec2"
  "owner"          = "Helene"
  "environment"    = "dev"
  "project"        = "jumbalaya"
  "create_by"      = "Terraform"
  "cloud_provider" = "aws"
  "company"        = "DEL"
}