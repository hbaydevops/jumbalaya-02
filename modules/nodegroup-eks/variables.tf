variable "aws_region" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "eks_version" {
  type = string
}
variable "node_min" {
  type = string
}
variable "desired_node" {
  type = string
}

variable "node_max" {
  type = string
}
variable "blue_node_color" {
  type    = string
  default = "blue"
}
variable "key_pair" {
  type        = string
  description = "SSH key to connect to the node from bastion host"
}
variable "deployment_nodegroup" {
  type = string
}

variable "capacity_type" {
  type        = string
  description = "Valid values: ON_DEMAND, SPOT"
  default     = "ON_DEMAND"
}
variable "ami_type" {
  type        = string
  description = "Valid values: AL2_x86_64, AL2_x86_64_GPU, AL2_ARM_64"
}
variable "instance_types" {
  type = string
}

variable "disk_size" {
  type = string
}
variable "shared_owned" {
  type        = string
  description = "Valid values are shared or owned"
  default     = "shared"
}

variable "enable_cluster_autoscaler" {
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
    "name"           = "demo-project-nodegroup"
    "owner"          = "jurist"
    "environment"    = "dev"
    "project"        = "blueops-nodegroup"
    "create_by"      = "Terraform"
    "cloud_provider" = "aws"
    "company"        = "DEL"
  }
}
