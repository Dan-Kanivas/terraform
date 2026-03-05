variable "ENV" {
  type = string
  default = "dev"
  description = "resource environment for tags"

#   validation {
#     condition = contains(["dev", "prod", "qa"],var.ENV)
#     error_message = "value is not contain from the list"
#   }
}

variable "INSTANCE_SIZE" {
  type = map(string)
  default = {
    "dev" = "t3.micro"
    "qa" = "t3.small"
    "prod" = "t3.large"
  }
  sensitive = true
}


variable "S3_BUCKET" {
  type = string
  default = "dan-s3-bucket-123456-testing"
  validation {
    condition = endswith(var.S3_BUCKET,"testing")
    error_message = "end with 'testing'"
  }
}
