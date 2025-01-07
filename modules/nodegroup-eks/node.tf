
# resource "aws_launch_template" "ubuntu" {
#   name          = format("%s-%s-%s-ec2", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
#   image_id      = data.aws_ami.ubuntu.id 
#   instance_type = var.instance_types
#   key_name = var.key_pair


#   tag_specifications {
#     resource_type = "instance"

#     tags = merge(var.common_tags, {
#       Name = format("%s-%s-%s-ec2", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
#     })
#   }
# }