source "amazon-ebs" "custom_server" {
  region        = var.aws_region
  instance_type = "t2.micro"
  source_ami_filter {
    filters = {
      "virtualization-type" = "hvm"
      "name"                = "ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"
      "root-device-type"    = "ebs"
    }
    owners      = ["099720109477"]
    most_recent = true
  }
  ssh_username = "ubuntu"
  ami_name     = var.ami_name

  tags = {
    Name = var.instance_name
  }
}

build {
  sources = [
    "source.amazon-ebs.custom_server"
  ]

  provisioner "shell" {
    script = "scripts/sonar.sh"  # Use script to copy the file
  }
  
  provisioner "shell" {
    script = "scripts/jenkins.sh"
  }

  provisioner "shell" {
    script = "scripts/docker.sh"
  }

  # Provision third shell script using inline commands



  # Add more shell provisioners as needed
}
