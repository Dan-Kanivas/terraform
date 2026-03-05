resource "aws_vpc" "dan-us-east-vpc" {
    cidr_block = var.us_east_vpc_cidr_block
    region = "us-east-1"
    provider = aws.us-east
    tags = {
      "Name" = var.us_east_vpc
    }
}

resource "aws_vpc" "dan-ap-southeast-vpc" {
    cidr_block = var.ap_southeast_vpc_cidr_block
    provider = aws.ap-southeast
    tags = {
      "Name" = var.ap_southeast_vpc
    }
}

resource "aws_subnet" "dan-us-east-subnet" {
  vpc_id = aws_vpc.dan-us-east-vpc.id
  cidr_block = var.us_east_vpc_subnet_cidr_block
  availability_zone = "us-east-1a"
  provider = aws.us-east
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.us_east_vpc}-subnet"
  }
}

resource "aws_subnet" "dan-ap-southeast-subnet" {
  vpc_id = aws_vpc.dan-ap-southeast-vpc.id
  cidr_block = var.ap_southeast_vpc_subnet_cidr_block
  provider = aws.ap-southeast
  map_public_ip_on_launch = true
  tags = {
    "Name" = "${var.ap_southeast_vpc}-subnet"
  }
}

resource "aws_internet_gateway" "ap-southeast-internet-gateway" {
  vpc_id = aws_vpc.dan-ap-southeast-vpc.id
  provider = aws.ap-southeast
}

resource "aws_internet_gateway" "us-east-internet-gateway" {
  vpc_id = aws_vpc.dan-us-east-vpc.id
  provider = aws.us-east
}

resource "aws_route_table" "us-east-public-route-table" {
  vpc_id = aws_vpc.dan-us-east-vpc.id
  provider = aws.us-east
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.us-east-internet-gateway.id
  }
}

resource "aws_route_table" "ap-southeast-public-route-table" {
  vpc_id = aws_vpc.dan-ap-southeast-vpc.id
  provider = aws.ap-southeast
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.ap-southeast-internet-gateway.id
  }
}

resource "aws_vpc_peering_connection" "us-east-to-ap-southeast" {
  provider = aws.us-east
  vpc_id = aws_vpc.dan-us-east-vpc.id
  peer_vpc_id = aws_vpc.dan-ap-southeast-vpc.id
  auto_accept = false
  peer_region = "ap-southeast-1"
}

resource "aws_vpc_peering_connection_accepter" "us-east-peering-connection-accepter" {
  vpc_peering_connection_id = aws_vpc_peering_connection.us-east-to-ap-southeast.id
  auto_accept = true
  provider = aws.ap-southeast
}


resource "aws_route" "us-east-route" {
  route_table_id = aws_route_table.us-east-public-route-table.id
  destination_cidr_block = "10.2.0.0/16"
  provider = aws.us-east
  vpc_peering_connection_id = aws_vpc_peering_connection.us-east-to-ap-southeast.id
  depends_on = [ aws_vpc_peering_connection_accepter.us-east-peering-connection-accepter ]
}  

resource "aws_route" "ap-southeast-route" {
  route_table_id = aws_route_table.ap-southeast-public-route-table.id
  destination_cidr_block = "10.1.0.0/16"
  provider = aws.ap-southeast
  vpc_peering_connection_id = aws_vpc_peering_connection.us-east-to-ap-southeast.id
  depends_on = [ aws_vpc_peering_connection_accepter.us-east-peering-connection-accepter ]
}

resource "aws_route_table_association" "us-east-public-route-table-association" {
  subnet_id = aws_subnet.dan-us-east-subnet.id
  route_table_id = aws_route_table.us-east-public-route-table.id
  provider = aws.us-east
}

resource "aws_route_table_association" "ap-southeast-public-route-table-association" {
  subnet_id = aws_subnet.dan-ap-southeast-subnet.id
  route_table_id = aws_route_table.ap-southeast-public-route-table.id
  provider = aws.ap-southeast
}


resource "aws_security_group" "dan-us-east-security-group" {
  vpc_id = aws_vpc.dan-us-east-vpc.id
  provider = aws.us-east
  name = var.us_east_security_group

  ingress {
    description = "ICMP from Primary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 22
    to_port = 22
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

resource "aws_security_group" "dan-ap-southeast-security-group" {
  vpc_id = aws_vpc.dan-ap-southeast-vpc.id
  provider = aws.ap-southeast
  name = var.ap_southeast_security_group

  ingress {
    description = "ICMP from Primary VPC"
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
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

resource "aws_key_pair" "us-east-dan-local-ssh-key" {
  key_name = "us-east-dan-local-ssh-key"
  provider = aws.us-east
#   key_type = "rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG9nNvx9aQ68C8fZKB5fbe4sP5jsh+UDoQOMuzp32VJwIy/ESxiAHYf5swyiKuI+W62RJ8kLWE/9d/DweB8JblLZIvt+0HGNqfEh19/gC/kBIWuHaX9lkK5UVw6DxQa7bfG/3RSSbcdht/HC4hKfbI4Az76ap/+B35Dwxq+W1zZKUVOSeSIEyaCMoEI+/SbX5E+qLAbmJwoDPYscKeMJZQXS7aRxO2sG4YIiv9HolTA4HF6uzyZccAS85JeMEyMld0JUadTAfwOvCZ49h5PuNGT841Y6wpVOljgMCsRJef+n3YgEi+n5C27rr1BHPky0ij8bUWOXXpln+Cev/3cuair38drLDVirbHYSHVtvFfi8L2s4/5IGKIF/Xwdy6MxMcvXk44wpBf2llBgNoSmGgYiNztyqsSO95mIwhPKFwXCG6jlcJOefk+iJi4K9UKruqDWoLFpsplSeVWtwFe5UJx8KGegw5nYcdH3xMyPkI/qTcfJ9vIFOUohnIMqgKPfGED3araKiwtHyAI1DPVSXq3D20o1tD0C0OJyZVxcCRWnuOL+hSRs4KVQ1ZZK3AxwEVYEUyj3AY26LnYDto33DksKjNUPtpgemLBsZlsCLVDWFRXW+2z7217objjEyyP4nr+3vdoERdW/JZ5imt57BzizdVHXwCo5G1dqkv9jJyFHw== kaung@Dan_Kanivas"
}

resource "aws_key_pair" "ap-southeast-dan-local-ssh-key" {
  key_name = "ap-southeast-dan-local-ssh-key"
  provider = aws.ap-southeast
#   key_type = "rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDG9nNvx9aQ68C8fZKB5fbe4sP5jsh+UDoQOMuzp32VJwIy/ESxiAHYf5swyiKuI+W62RJ8kLWE/9d/DweB8JblLZIvt+0HGNqfEh19/gC/kBIWuHaX9lkK5UVw6DxQa7bfG/3RSSbcdht/HC4hKfbI4Az76ap/+B35Dwxq+W1zZKUVOSeSIEyaCMoEI+/SbX5E+qLAbmJwoDPYscKeMJZQXS7aRxO2sG4YIiv9HolTA4HF6uzyZccAS85JeMEyMld0JUadTAfwOvCZ49h5PuNGT841Y6wpVOljgMCsRJef+n3YgEi+n5C27rr1BHPky0ij8bUWOXXpln+Cev/3cuair38drLDVirbHYSHVtvFfi8L2s4/5IGKIF/Xwdy6MxMcvXk44wpBf2llBgNoSmGgYiNztyqsSO95mIwhPKFwXCG6jlcJOefk+iJi4K9UKruqDWoLFpsplSeVWtwFe5UJx8KGegw5nYcdH3xMyPkI/qTcfJ9vIFOUohnIMqgKPfGED3araKiwtHyAI1DPVSXq3D20o1tD0C0OJyZVxcCRWnuOL+hSRs4KVQ1ZZK3AxwEVYEUyj3AY26LnYDto33DksKjNUPtpgemLBsZlsCLVDWFRXW+2z7217objjEyyP4nr+3vdoERdW/JZ5imt57BzizdVHXwCo5G1dqkv9jJyFHw== kaung@Dan_Kanivas"
}

resource "aws_instance" "us-east-ec2-instance" {
  ami = "ami-0532be01f26a3de55"
  instance_type = "t3.micro"
  region = "us-east-1"
  subnet_id = aws_subnet.dan-us-east-subnet.id
  vpc_security_group_ids = [aws_security_group.dan-us-east-security-group.id]
  provider = aws.us-east
  key_name = aws_key_pair.us-east-dan-local-ssh-key.key_name
  associate_public_ip_address = true
  tags = {
    "Name" = var.us-east-ec2-instance
  }
  depends_on = [ aws_vpc_peering_connection_accepter.us-east-peering-connection-accepter ]
}

resource "aws_instance" "ap-southeast-ec2-instance" {
  ami = "ami-0ac0e4288aa341886"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.dan-ap-southeast-subnet.id
  vpc_security_group_ids = [aws_security_group.dan-ap-southeast-security-group.id]
  provider = aws.ap-southeast
  region = "ap-southeast-1"
  key_name = aws_key_pair.ap-southeast-dan-local-ssh-key.key_name
  associate_public_ip_address = true
  tags = {
    "Name" = var.ap-southeast-ec2-instance
  }
  depends_on = [ aws_vpc_peering_connection_accepter.us-east-peering-connection-accepter ]
}