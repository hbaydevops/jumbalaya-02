# Create an AMI from EC2 instance
resource "aws_ami_from_instance" "blueops_ami" {
  name     = format("%s-instance-ami", var.common_tags["project"])
  source_instance_id = data.aws_instance.existing_instance.id
   #no_reboot   = var.no_reboot 

    tags = merge(var.common_tags, {
    Name = format("%s-instance-ami", var.common_tags["project"])
    },
  )
}



