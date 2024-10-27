# # Create an EC2 instance
# resource "aws_instance" "my_ec2" {
#   ami                    = data.aws_ami.ubuntu.id
#   #ami                    = "ami-09560dc345174d6df"
#   instance_type          = var.instance_type
#   key_name               = var.key_name
#   vpc_security_group_ids = [data.aws_security_group.existing_sg.id]

#   user_data = <<-EOF
#               #!/bin/bash
#               ${file("${path.module}/scripts/docker.sh")}
    
#               $(file("${path.module}/jenkins_master.sh"))
#   EOF
           
            

#   tags = merge(var.common_tags, {
#     Name = format("%s-%s-%s-ec2", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
#     },
#   )
# }

resource "aws_instance" "servers" {
  count                  = 2  
  ami                    = count.index == 0 ? data.aws_ami.my_existing_ami.id : data.aws_ami.ubuntu.id
  instance_type          = count.index == 0 ? "t2.medium" : var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [data.aws_security_group.existing_sg.id]

  # user_data = <<-EOF
  #             #!/bin/bash
  #             ${
  #               count.index == 0 ? 
  #               "${file("${path.module}/scripts/docker.sh")}\n${file("${path.module}/scripts/jenkins_master.sh")}" :
  #               file("${path.module}/scripts/jenkins_slave.sh")
  #             }
  # EOF

  #user_data = count.index == 1 ? file("${path.module}/scripts/jenkins_slave.sh") : null

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-%s", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"],
    count.index == 0 ? "main-server" : "jenkins-slave")
  })
}
