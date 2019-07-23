module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.3.0"

  identifier = "demodb"

  engine               = "postgres"
  engine_version       = "9.6.11"
  instance_class       = "${var.instance_type}"
  allocated_storage     = 5


  vpc_security_group_ids = "${var.vpc_security_group_ids}"
  # DB subnet group
  subnet_ids = "${var.vpc_subnets}"

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  username = "demouser"
  password = "YourPwdShouldBeLongAndSecure!"
  port     = "5432"

  tags = {
    Environment = "dev"
    Terraform = true
  }

  apply_immediately	= true
  storage_encrypted = false

  # required params. TODO: find out how to disable/enable
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window     = "03:00-06:00"

  # kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
  name = "demodb"



  # disable backups to create DB faster
  backup_retention_period = 0

  # DB parameter group
  family = "postgres9.6"

  # DB option group
  major_engine_version = "9.6"

  skip_final_snapshot  = true

  # Database Deletion Protection
  deletion_protection = false
}