# Create an Elastic IP
resource "aws_eip" "my_eip" {
  count      = 3  
  instance   = aws_instance.servers[count.index].id
  domain   = "vpc"

  tags = merge(var.common_tags, {
    Name = format("%s-%s-%s-eip", var.common_tags["environment"], var.common_tags["owner"], var.common_tags["project"])
    },
  )
}
