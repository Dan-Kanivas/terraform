# locals {
# #   toConcat = concat(var.DAN_LOCATION,var.PHYO_LOCATION)
# #   toSet = toset(local.toConcat)

# #   toAbs = [for cost in var.COST_LIST : abs(cost)]

# #   findMax = max(local.toAbs...)
# #   findMin = min(local.toAbs...)
# #   total = sum(local.toAbs)

# #   current_time = timestamp()

# #   formatted_current_time = formatdate("YYYY-MM-DD", local.current_time)
# }

# # resource "aws_s3_bucket" "testing_4_formatted_time_bucket" {
# #   bucket = "dan-formatted-time-bucket${local.formatted_current_time}"
# # }

locals {
  is_json_file_exist = fileexists("./config.json")

  config_data = local.is_json_file_exist == true ? jsondecode(file("./config.json")) : {
    database = {
        host = "localhost",
        port = 1224,
        username = "dan"
    }
  }
}

resource "aws_secretsmanager_secret" "secret_manager" {
  name = "dan_secret_manager_testing"
  description = "dan_testing"
}

resource "aws_secretsmanager_secret_version" "dan_secret_manager_version" {
  secret_id = aws_secretsmanager_secret.secret_manager.id
  secret_string = jsonencode(local.config_data)
}
