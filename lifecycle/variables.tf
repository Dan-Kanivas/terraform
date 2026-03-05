variable "S3_BUCKET" {
  type = string
  description = "This is the variable of S3 BUCKET"
  default = "dan-s3-bucket-4-lifecycle-testing"
}

variable "EC2_AMI" {
    type = string
    description = "This is the variable of EC2 AMI"
    default = "ami-0532be01f26a3de55"
}

variable "EC2_INSTANCE_TYPE" {
    type = string
    description = "This is the variable of EC2 INSTANCE TYPE"
    default = "t3.micro"
}

variable "ASSO_PUB_IP" {
  type = bool
  description = "This is the variable of ASSO_PUB_IP"
  default = true
}

variable "EC2_TAG_NAME" {
    type = map(string)
    description = "This is the variable of VC_TAG_NAME"
    default = {
        "Name" = "Dan-EC2-Instance-4-lifecycle-V2"
        "Environment" = "Testing"
    }
  
}