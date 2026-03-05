variable "us_east_vpc" {
    type = string
    default = "dan_us_east_vpc"
  }
variable "ap_southeast_vpc" {
    type = string
    default = "dan_ap_southeast_vpc"
  }

variable "us_east_vpc_cidr_block" {
  type = string
  default = "10.1.0.0/16"
}

variable "ap_southeast_vpc_cidr_block" {
  type = string
  default = "10.2.0.0/16"
}

variable "us_east_vpc_subnet_cidr_block" {
  type = string
  default = "10.1.1.0/24"
}

variable "ap_southeast_vpc_subnet_cidr_block" {
  type = string
  default = "10.2.1.0/24"
}

variable "us_east_security_group" {
  type = string
  default = "dan_us_east_security_group"
}

variable "ap_southeast_security_group" {
  type = string
  default = "dan_ap_southeast_security_group"
}

variable "us-east-ec2-instance" {
    type =  string
    default = "dan-us-east-ec2-instance"
}

variable "ap-southeast-ec2-instance" {
    type =  string
    default = "dan-ap-southeast-ec2-instance"
}
