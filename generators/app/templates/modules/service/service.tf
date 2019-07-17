resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = "${var.vpc_id}"

  ingress {
    # TLS (change to whatever ports you need)
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}

resource "aws_elastic_beanstalk_application" "beanstalk_demo_api" {
  name        = "beanstalk-demo-api"
  description = "POC of beanstalk deployment"

  tags = {
    project = "beanstalk-demo-api"
  }
}

# module "elastic-beanstalk-environment" {
#   source  = "cloudposse/elastic-beanstalk-environment/aws"
#   version = "0.3.10"

#   # insert the 6 required variables here
#   app         = "${aws_elastic_beanstalk_application.beanstalk_demo_api.name}"
#   keypair     = ""
# }

resource "aws_elastic_beanstalk_environment" "beanstalk_demo_api_dev" {
  name                = "beanstalk-demo-api-dev"
  application         = "${aws_elastic_beanstalk_application.beanstalk_demo_api.name}"
  solution_stack_name = "64bit Amazon Linux 2018.03 v2.12.14 running Docker 18.06.1-ce"

  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "EnvironmentType"
    value     = "SingleInstance"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "SecurityGroups"
    value     = "${aws_security_group.allow_ssh.id}"
  }

  # EC2 instance profile used by beanstalk
  # Default profile created by AWS is aws-elasticbeanstalk-ec2-role
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = "${var.vpc_id}"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = "${ join(",", var.vpc_subnets_ids) }" # list to string
  }
}
