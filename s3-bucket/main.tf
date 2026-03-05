terraform {
  backend "s3" {
    bucket         = "dan-s3-bucket-4-terraform-stage"
    key            = "dan/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = "true"
    encrypt        = true
  }
  required_providers {
    aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "dan-s3-bucket" {
  bucket = "dan-s3-bucket-12345"
}

resource "aws_s3_bucket" "dan-s3-bucket-v1" {
  bucket = "dan-s3-bucket-v1-12345"
}