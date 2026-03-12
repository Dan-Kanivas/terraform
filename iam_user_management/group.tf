resource "aws_iam_group" "dan_iam_groups" {
    for_each = { for user in local.users : user.department => user}
    name = each.value.department
    path = "/group/"
}

# output "dan_iam_groups" {
#   value =  [
#     for group in aws_iam_group.dan_iam_groups : group.name
#   ]
# }

resource "aws_iam_group_membership" "dan_iam_group_membership" {
  for_each = toset([ for group in aws_iam_group.dan_iam_groups : group.name ])
  name = each.value
  users = [for user in aws_iam_user.aws_iam_users : user.name if user.tags.Department == each.value]
  group = each.value
}