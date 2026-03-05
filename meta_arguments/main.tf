resource "aws_s3_bucket" "S3_Dan_Bucket_List" {
  count = length(var.S3_BUCKET_NAME_LIST)
  bucket = var.S3_BUCKET_NAME_LIST[count.index]
}

resource "aws_s3_bucket" "S3_Dan_Bucket" {
  for_each = var.S3_BUCKET_NAME
  bucket = each.value
  depends_on = [ aws_s3_bucket.S3_Dan_Bucket_List ]
}

