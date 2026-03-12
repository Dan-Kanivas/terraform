variable "APP_NAME" {
  type = string
  default = "dan-beanstalk-testing"
}

variable "BLUE_APP_VERSION" {
    type = string
    default = "v1"
}

variable "GREEN_APP_VERSION" {
    type = string
    default = "v2"
}

variable "SOLUTION_STACK_NAME" {
  description = "Elastic Beanstalk solution stack name (platform)"
  type        = string
  # Node.js 24 running on 64bit Amazon Linux 2023
  default = "Node.js 20 running on 64bit Amazon Linux 2023"
}

variable "INSTANCE_TYPE" {
    type = string
    default = "t3.micro"
}