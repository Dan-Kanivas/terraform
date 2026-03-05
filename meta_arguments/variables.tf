variable "S3_BUCKET_NAME" {
  type = set(string)
  description = "this is the testing of set variable type"
  default = ["this-is-first-string-to-create-s3-bucket", "this-is-second-string-to-create-s3-bucket"]
}

variable "S3_BUCKET_NAME_LIST" {
  type = list(string)
  description = "this is the testing of list variable type"
  default = [ "this-is-first-list-string-to-create-s3-bucket", "this-is-second-list-string-to-create-s3-bucket" ]
}
