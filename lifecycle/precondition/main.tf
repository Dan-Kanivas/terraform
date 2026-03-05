resource "aws_s3_bucket" "dan-precondition-bucket" {
  bucket = var.BUCKET_NAME

  lifecycle {
    precondition {
      condition = (var.BUCKET_NAME == "dan-precondition-bucket-testing")
      error_message = "Bucket name not matching"
    }
  }
}

resource "aws_s3_bucket" "dan-postcondition-bucket" {
  bucket = var.BUCKET_NAME

  tags = {
    "Env" = var.S3_ENV
  }

  lifecycle {
    postcondition {
      condition = (var.S3_ENV == "Testing")
      error_message = "Bucket tags not matching"
    }
  }
}