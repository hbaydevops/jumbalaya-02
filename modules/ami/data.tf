/*data "aws_ami" "blueops_ami" {
  filter {
    name   = "name"
    values = ["*-instance-ami"]  
  }

  owners = ["IT"]  # 'self' refers to the current AWS account

  most_recent = true
}
*/

data "aws_instance" "existing_instance" {
  filter {
    name   = "tag:Name"      
    values = ["dev-jurist-demo-project-main-server"]  
  }
}

