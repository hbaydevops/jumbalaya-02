variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "source_instance_id" {
  type    = string
  
}

variable "no_reboot" {
  type    = bool
  default = true
}

variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "name"             = "blueops-ami"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company" = "DEL"
  }
}
