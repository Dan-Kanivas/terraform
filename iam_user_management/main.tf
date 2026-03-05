data "aws_caller_identity" "Dan" {
}

output "Dan-Account-Id" {
  value = data.aws_caller_identity.Dan.account_id
}

