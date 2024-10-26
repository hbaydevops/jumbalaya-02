# Output the instance ID from the module
output "source_instance_id" {
  value = module.AMI.instance_id  # Get the instance_id from the module's output
}
