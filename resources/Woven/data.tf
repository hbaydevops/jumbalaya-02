# Load the JSON file into Terraform
data "local_file" "policy" {
  filename = "${path.module}/policy.json"
}

# Decode the JSON content
locals {
  policy = jsondecode(data.local_file.policy.content)
}

# Iterate over each statement and output values
output "policy_statements" {
  value = [
    for i in local.policy["Statement"] : {
      effect    = statement["Effect"]
      actions   = statement["Action"]
      resources = statement["Resource"]
      condition = try(statement["Condition"], null)
    }
  ]
}
