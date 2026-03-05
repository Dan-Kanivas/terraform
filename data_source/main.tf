data "aws_vpc" "default_us_east" {
  region = "us-east-1"
  default = true
}

data "aws_vpc" "default_asia" {
  region = "ap-southeast-1"
  default = true
}

output "us_east_vpc_id" {
  value = data.aws_vpc.default_us_east.id
}

output "asia_vpc_id" {
  value = data.aws_vpc.default_asia.id
}

output "us_east_vpc_cidr" {
  value = data.aws_vpc.default_us_east.cidr_block
}

resource "aws_subnet" "us_east_default_subnet" {
  vpc_id = data.aws_vpc.default_us_east.id
  cidr_block = "172.31.100.0/24"
  availability_zone = "us-east-1a"
}