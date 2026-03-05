# data "aws_ami" "dan-aws-ami-data" {
#   most_recent = true
#   owners = ["amazon"]

#   filter {
#     name = "name"
#     values = ["amzn2-ami-hvm-*-x86_64-gp2"]
#     #values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-*-amd64-*"]
#   }

#   filter {
#     name = "virtualization-type"
#     values = ["hvm"]
#   }
# }

resource "aws_launch_template" "dan-launch-template" {
  name_prefix = "dan-launch-template"
  image_id = data.aws_ami.dan-aws-ami-data.id
  instance_type = var.EC2_INSTANCE_TYPE

  tag_specifications {
    resource_type = "instance"
    tags = var.EC2_INSTANCE_TAGS
  }
}

# resource "aws_autoscaling_group" "dan-auto-scaling-group" {
#   name = "dan-auto-scaling-group"
#   availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]
#   min_size = 1
#   max_size = 4
#   desired_capacity = 2

#   launch_template {
#     id = aws_launch_template.dan-launch-template.id
#     version = "$Latest"
#   }

#   lifecycle {
#     ignore_changes = [ desired_capacity,min_size,max_size ]
#   }
# }

# output "ami_arch" {
#   value = data.aws_ami.dan-aws-ami-data.architecture
# }



# resource "aws_s3_bucket" "compliance_bucket" {
#   bucket = "compliance-bucket-4-postcondition"

#   tags = {
#       Name       = "Compliance Validated Bucket"
#       Demo       = "postcondition"
#       Compliance = "SOC2"
#       Environment= "Testing"
#     }

#   # Lifecycle Rule: Validate bucket has required tags after creation
#   # This ensures compliance with organizational tagging policies
#   lifecycle {
#     postcondition {
#       condition     = contains(keys(self.tags), "Compliance")
#       error_message = "ERROR: Bucket must have a 'Compliance' tag for audit purposes!"
#     }

#     postcondition {
#       condition     = contains(keys(self.tags), "Environment")
#       error_message = "ERROR: Bucket must have an 'Environment' tag!"
#     }
#   }
# }

