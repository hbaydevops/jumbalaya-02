output "security_group_id" {
  description = "The ID of the security group allowing SSH."
  value       = data.aws_security_group.existing_sg.id
}



output "instance_id" {
  value = [for i in range(0, 2) : aws_instance.servers[i].id]  # Collecting all instance IDs in a list
}
# output "instance_id" {
#   value = aws_instance.my_ec2  # Collecting all instance IDs in a list
# }