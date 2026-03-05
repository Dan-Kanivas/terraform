terraform {
  backend "s3" {
    bucket = "dan-s3-bucket-4-terraform-stage"
    key = "lifecycle-precondition/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    use_lockfile = "true"
  }
}