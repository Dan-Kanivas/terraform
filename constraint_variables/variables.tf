variable "dan-s3" {
  description = "This is dan s3 variables. this should be string"
  type = string
  default = "dan-s3"
}

variable "environment" {
  description = "This is the environment type of project"
  type = string
  default = "dev"
}

variable "s3-count" {
  type = number
  description = "Please type a number you want to create -"
}

variable "VPC_NAME" {
  type = string
  default = "Dan-VPC"
}

variable "REGION" {
  type = string
  default = "us-east-1"
}

variable "VPC_CIDR_BLOCK" {
  type = string
  default = "192.168.0.0/16"
}

variable "SUBNET_CIDR_BLOCK" {
  type = string
  default = "192.168.1.0/24"
}

variable "AZ" {
  type = string
  default = "us-east-1a"
}

variable "SUBNET_NAME" {
  type = string
  default = "Dan-aws-subnet-az-a"
}

variable "SG_NAME" {
  type = string
  default = "Dan-aws-security-group"
}

variable "SG_INGRESS_PORT" {
  type = number
  default = 80
}

variable "EC2_NAME" {
  type = string
  default = "Dan-aws-ec2-instance"
}

variable "ASSO_PUB_IP" {
  type = bool
  default = true
}

variable "INSTANCE_TYPE" {
  type = list(string)
  default = ["t3.micro","t3.small","t3.large"]
}

variable "INSTANCE_COUNT" {
  type = number
  default = 2
}

variable "INSTANCE_TAGS" {
  type = map(string)
  description = "Bla Bla"
  default = {
    "Name" = "Terraform Testing with Phyo"
    "ENV" = "Production"
  }
}

variable "tuple_testing" {
  type = tuple([string,number,bool])  
  description = "Bla Bla"
  default = [ "Dan", 12345, false ]
}

variable "EC2_CONFIG_VARS" {
  type = object({
    EC2_Name = string
    EC2_INSTANCE_TYPE = string
    EC2_AMI = string
  })
  default = {
    EC2_Name = "Dan-Testing-instance"
    EC2_INSTANCE_TYPE = "t3.micro"
    EC2_AMI = "ami-0532be01f26a3de55"
  }
}