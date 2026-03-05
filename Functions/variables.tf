variable "DAN_S3_BUCKET_NAME" {
  type = string
  default = " Dan S3 Bucket Name 123456 "
}

variable "S3_TAGS" {
  type = map(string)
  default = {
    "Env" = "Testing"
    "Team" = "Operation"
  }
}

variable "SPLIT_VARIABLE" {
  type = string
  default = "dan-s3-bucket-4-split-function,phyo-s3-bucket-4-split-function"
}