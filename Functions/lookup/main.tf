locals {
  INSTANCE_TYPE = lookup(var.INSTANCE_SIZE, var.ENV,"t3.micro")
  S3_BUCKET = var.S3_BUCKET
}

resource "aws_instance" "Lookup_instance" {
  ami = "ami-0532be01f26a3de55"
#   instance_type = lookup(var.INSTANCE_SIZE, var.ENV,"t3.micro")
  instance_type = local.INSTANCE_TYPE
}

resource "aws_instance" "Lookup_instance-1" {
  ami = "ami-0532be01f26a3de55"
#   instance_type = lookup(var.INSTANCE_SIZE, var.ENV,"t3.micro")
  instance_type = local.INSTANCE_TYPE
}


resource "aws_s3_bucket" "name" {
  bucket = local.S3_BUCKET
}