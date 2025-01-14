data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# data "aws_ssm_parameter" "ubuntu_ami" {
#   name = "/aws/service/canonical/ubuntu/eks/20.04/stable/current/arm64/hvm/ebs-gp2/ami-id"
# }