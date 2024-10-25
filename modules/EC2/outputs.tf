output "security_group_id" {
  description = "The ID of the security group allowing SSH."
  value       = data.aws_security_group.existing_sg.id
}


# Output the instance ID
output "instance_id" {
  value = [for i in range(0, 3) : aws_instance.servers[i].id]  # Collecting all instance IDs in a list
}
