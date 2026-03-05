terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias = "us-east"
}

provider "aws" {
  region = "ap-southeast-1"
  alias = "ap-southeast"
}