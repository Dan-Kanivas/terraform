resource "aws_s3_object" "Dan-upload-green-evn-object" {
    bucket = aws_s3_bucket.dan_beanstalk_bucket.id
    key = "app-v2.zip"
    source = "${path.module}/green-app/app-v2.zip"
    force_destroy = true
}

resource "aws_elastic_beanstalk_application_version" "beanstalk_green_app_version" {
  name = "${var.APP_NAME}-${var.GREEN_APP_VERSION}"
  application = aws_elastic_beanstalk_application.dan-beanstalk_app.name
  bucket = aws_s3_bucket.dan_beanstalk_bucket.id
  key = aws_s3_object.Dan-upload-green-evn-object.key

}

resource "aws_elastic_beanstalk_environment" "deanstalk_green_env" {
  name = "${var.APP_NAME}-green"
  application = aws_elastic_beanstalk_application.dan-beanstalk_app.name
  version_label = aws_elastic_beanstalk_application_version.beanstalk_green_app_version.name
  #solution_stack_name = var.SOLUTION_STACK_NAME
  platform_arn = "arn:aws:elasticbeanstalk:us-east-1::platform/Node.js 24 running on 64bit Amazon Linux 2023/6.8.0"

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "IamInstanceProfile"
    value = aws_iam_instance_profile.beanstalk_instance_profile.name
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "ServiceRole"
    value = aws_iam_role.beanstalk_service_role.name
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name = "InstanceType"
    value = var.INSTANCE_TYPE
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "EnvironmentType"
    value = "LoadBalanced"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name = "LoadBalancerType"
    value = "application"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MinSize"
    value = "1"
  }

  setting {
    namespace = "aws:autoscaling:asg"
    name = "MaxSize"
    value = "2"
  }

  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name = "SystemType"
    value = "enhanced"
  }

  # setting {
  #   namespace = "aws:elasticbeanstalk:environment:process:default"
  #   name = "HealthCheckType"
  #   value = "/"
  # }

 setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Port"
    value     = "8080"
  }

  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "Protocol"
    value     = "HTTP"
  }

  setting {
    namespace = "aws:elasticbeanstalk:application:environment"
    name      = "APP_VERSION"
    value     = "green"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "DeploymentPolicy"
    value     = "Rolling"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSizeType"
    value     = "Percentage"
  }

  setting {
    namespace = "aws:elasticbeanstalk:command"
    name      = "BatchSize"
    value     = "50"
  }


  setting {
    namespace = "aws:elasticbeanstalk:managedactions"
    name      = "ManagedActionsEnabled"
    value     = "false"
  }

}