# resource "aws_s3_bucket" "Dan-s3-bucket" {
#   bucket = var.S3_BUCKET

#   lifecycle {
#     create_before_destroy = true
#   }
# }


resource "aws_instance" "Dan-instance" {
    ami = var.EC2_AMI
    instance_type = var.EC2_INSTANCE_TYPE
    #subnet_id = aws_subnet.Dan-aws-subnet-az-a.id
    #vpc_security_group_ids = [aws_security_group.Dan-aws-security-group.id]
    #associate_public_ip_address = var.ASSO_PUB_IP

    tags = var.EC2_TAG_NAME
    #tags = "Dan-EC2-Instance-4-lifecycle"
    #tags = {
    #    Name = "Dan-EC2-Instance-4-lifecycle"
    # }


    lifecycle {
      #create_before_destroy = true
      #prevent_destroy = true
      ignore_changes = [ tags ]
    }
}