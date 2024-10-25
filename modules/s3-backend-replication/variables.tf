variable "aws_region_main" {
  type    = string
  default = "us-east-2"
}

variable "aws_region_backup" {
  type    = string
  default = "us-east-1"
}

variable "force_destroy" {
  type    = bool
  default = true
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "demo-project"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company" = "DEL"
  }
}
