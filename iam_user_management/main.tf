data "aws_caller_identity" "Dan" {
}

# output "Dan-Account-Id" {
#   value = data.aws_caller_identity.Dan.account_id
# }

locals {
  users = csvdecode(file("users.csv"))
}

# output "users" {
#   value = [for user in local.users: "${user.first_name} ${user.last_name}"]
# }

resource "aws_iam_user" "aws_iam_users" {
  for_each = { for user in local.users : user.first_name => user}
  name = "${lower(replace(each.value.first_name," ",""))}${lower(replace(each.value.last_name," ",""))}"
  path = "/users/"

  tags = {
    "DisplayName" = "${each.value.first_name} ${each.value.last_name}"
    "Department" = "${each.value.department}"
    "job_title" = "${each.value.job_title}"
  }
}

resource "aws_iam_user_login_profile" "users_login_profile" {
  for_each = aws_iam_user.aws_iam_users
  user = each.value.name
  password_length = 8
  password_reset_required = true

}

# output "profile" {
#   value = aws_iam_user_login_profile.users_login_profile
#   sensitive = true
# }

output "aws_iam_users_password" {
  value = {
    for user,profile in aws_iam_user_login_profile.users_login_profile : user => profile.password
  }
  sensitive = true
}
# output "aws_iam_users_after_created" {
#   value = aws_iam_user.aws_iam_users
# }
