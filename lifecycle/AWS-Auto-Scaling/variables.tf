variable "EC2_INSTANCE_TYPE" {
  type = string
  default = "t3.micro"
}

variable "EC2_INSTANCE_TAGS" {
    type = map(string)
    default = {
      "Name" = "dan-auto-scaling-instance"
      "Environment" = "dev"
    }
}