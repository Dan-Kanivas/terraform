# locals {
#   s3_bucket_name = lower(replace(trimspace(var.DAN_S3_BUCKET_NAME), " ", "-"))
#   s3_backet_name_substr = substr(local.s3_bucket_name, 0, 63)
# }

# resource "aws_s3_bucket" "Dan_S3_Bucket" {
#   bucket = local.s3_backet_name_substr

#   tags = merge(var.S3_TAGS,
#     {
#      "Name" : "Ecommerce Platform"
#     }
#     )
#     lifecycle {
#       prevent_destroy = true
#     }
# }

locals {
  split_list_variable = split(",", var.SPLIT_VARIABLE)
}

resource "aws_s3_bucket" "Dan_s3_bucket_4_split_function" {
  for_each = toset(local.split_list_variable)
  bucket = each.value
  
}