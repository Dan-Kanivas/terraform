terraform {
  backend "s3" {
    bucket = "dan-s3-bucket-4-terraform-stage"
    region = "us-east-1"
    key = "meta_arguments/terraform.tfstate"
    use_lockfile = "true"
    encrypt = true
  }
}