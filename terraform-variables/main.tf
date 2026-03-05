# resource "aws_s3_bucket" "dan-variables-day-s3-bucket" {
#   bucket = "dan-variables-day-s3-bucket"
#   tags = {
#     gp = var.group
#     loc = var.location
#   }
# }

resource "aws_vpc" "Dan-VPC" {
  cidr_block = "192.168.0.0/16"
  region = "us-east-1"
  tags = {
    Name = "Dan-VPC"
  }
}

resource "aws_subnet" "Dan-aws-subnet-az-a" {
  vpc_id = aws_vpc.Dan-VPC.id
  cidr_block = "192.168.1.0/24"
  availability_zone       = "us-east-1a"
  tags = {
    Name = "Dan-aws-subnet-az-a"
  }
}

resource "aws_security_group" "Dan-aws-security-group" {
  name = "Dan-aws-security-group"
  vpc_id = aws_vpc.Dan-VPC.id
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "Dan-aws-ec2-instance" {
  instance_type = "t3.micro"
  ami = "ami-0532be01f26a3de55"
  # region = "us-east-1a"
  subnet_id = aws_subnet.Dan-aws-subnet-az-a.id
  vpc_security_group_ids = [aws_security_group.Dan-aws-security-group.id]
  associate_public_ip_address = true
  
  tags = {
    Name = "Dan-aws-ec2-instance"
  }
}
