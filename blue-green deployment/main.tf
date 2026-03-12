resource "aws_iam_role" "beanstalk_ec2_role" {
  name = "${var.APP_NAME}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  }) 
}

resource "aws_iam_role_policy_attachment" "beanstalk_web_tier_policy" {
  role = aws_iam_role.beanstalk_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}

resource "aws_iam_role_policy_attachment" "beanstalk_worker_tier_policy" {
  role = aws_iam_role.beanstalk_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
}

resource "aws_iam_role_policy_attachment" "beanstalk_mulitcontainer_tier_policy" {
  role = aws_iam_role.beanstalk_ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
}

resource "aws_iam_instance_profile" "beanstalk_instance_profile" {
  name = "${var.APP_NAME}-instance-profile"
  role = aws_iam_role.beanstalk_ec2_role.name
}

resource "aws_iam_role" "beanstalk_service_role" {
  name = "${var.APP_NAME}-service-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "elasticbeanstalk.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "beanstalk_servic_health" {
    role = aws_iam_role.beanstalk_service_role.name
    policy_arn = "arn:aws:iam::aws:policy/service-role/AWSElasticBeanstalkEnhancedHealth"
}

resource "aws_iam_role_policy_attachment" "beanstalk_service_managed_updates" {
  role = aws_iam_role.beanstalk_service_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
}

resource "aws_elastic_beanstalk_application" "dan-beanstalk_app" {
  name = var.APP_NAME
  description = "Dan Blue-Green deployment"
}

resource "aws_s3_bucket" "dan_beanstalk_bucket" {
  bucket = "${var.APP_NAME}-bucket-20260312"
}

resource "aws_s3_bucket_public_access_block" "dan-beanstalk-app-accwss-block" {
  bucket = aws_s3_bucket.dan_beanstalk_bucket.id

  block_public_acls = true
  block_public_policy = true
  ignore_public_acls = true
  restrict_public_buckets = true
}
