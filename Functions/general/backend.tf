terraform {
  backend "s3" {
    bucket = "dan-s3-bucket-4-terraform-stage"
    region = "us-east-1"
    key = "functions/general/terraform.tfstate"
    encrypt = true
    use_lockfile = true
  }
}