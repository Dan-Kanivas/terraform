# resource "aws_s3_bucket" "Dan-s3-bucket" {
#   count = var.s3-count
#   bucket = "${var.environment}-${var.dan-s3}-${count.index}"
# }

## Create EC2 instance with Custom VPC
resource "aws_vpc" "Dan-VPC" {
  cidr_block = var.VPC_CIDR_BLOCK
  region = var.REGION
  tags = {
    Name = var.VPC_NAME
  }
}

resource "aws_subnet" "Dan-aws-subnet-az-a" {
  vpc_id = aws_vpc.Dan-VPC.id
  cidr_block = var.SUBNET_CIDR_BLOCK
  availability_zone       = var.AZ
  tags = {
    Name = var.SUBNET_NAME
  }
}

resource "aws_security_group" "Dan-aws-security-group" {
  name = var.SG_NAME
  vpc_id = aws_vpc.Dan-VPC.id
  ingress {
    from_port = var.SG_INGRESS_PORT
    to_port = var.SG_INGRESS_PORT
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
  count = var.INSTANCE_COUNT
  instance_type = var.INSTANCE_TYPE[count.index]
  ami = "ami-0532be01f26a3de55"
  # region = "us-east-1a"
  subnet_id = aws_subnet.Dan-aws-subnet-az-a.id
  vpc_security_group_ids = [aws_security_group.Dan-aws-security-group.id]
  associate_public_ip_address = var.ASSO_PUB_IP
  
  tags = var.INSTANCE_TAGS
}


resource "aws_instance" "Object_constraint_testing" {
  instance_type = var.EC2_CONFIG_VARS.EC2_INSTANCE_TYPE
  ami = var.EC2_CONFIG_VARS.EC2_AMI

  subnet_id = aws_subnet.Dan-aws-subnet-az-a.id
  vpc_security_group_ids = [aws_security_group.Dan-aws-security-group.id]
  associate_public_ip_address = var.ASSO_PUB_IP

  tags = {
    Name = var.EC2_CONFIG_VARS.EC2_Name
  }
}