# Output the security group ID
output "instance_id" {
  value       = data.aws_instance.existing_instance.id
  description = "The ID of the EC2 instance"
}



