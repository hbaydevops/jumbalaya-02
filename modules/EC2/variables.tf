variable "aws_region" {
  type    = string
  default = "us-east-1"
}
variable "docker_script" {
  type = string
  default = "./scripts/docker.sh"
}
variable "docker_sonar_script" {
  type = string
  default = "./scripts/docker_sonar.sh"
}

variable "jenkins_master_script" {
  type = string
  default = "./scripts/jenkins_master.sh"
}

variable "jenkins_slave_script" {
  type = string
  default = "./scripts/jenkins_slave.sh"
}
variable "instance_type" {
  type    = string
  default = "t2.micro"
}
variable "key_name" {
  type    = string
  default = "jenkins-master-slave-sonar"
}
variable "force_destroy" {
  type    = bool
  default = true
}
variable "volume_size"{
  type = number
  default = 30
}
variable "common_tags" {
  type = map(any)
  default = {
    "id"             = "2024"
    "name"           = "jumbalaya-ec2"
    "owner"          = "Helene"
    "environment"    = "dev"
    "project"        = "jumbalaya"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}
