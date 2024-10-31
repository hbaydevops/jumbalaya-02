# Terraform backend configuration
terraform {
  backend "s3" {
    bucket         = "dev-demo-project-jurist-tf-state"
    key            = "EC2/terraform.tfstate"
    region         = "us-east-2"
    dynamodb_table = "dev-demo-project-jurist-tf-state-lock"
    encrypt        = true
  }
}