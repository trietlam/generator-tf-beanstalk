module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.7.0"

  name = "${var.vpc_config.name}"
  cidr = "10.0.0.0/16"

  azs              = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
  # private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  # public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  # database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]
  private_subnets  = "${var.vpc_config.private_subnets}"
  public_subnets   = "${var.vpc_config.public_subnets}"
  database_subnets = "${var.vpc_config.database_subnets}"

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "${var.vpc_config.env}"
  }
}

# module "vpc_uat" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "2.7.0"

#   name = "uat-vpc-beanstalk-demo-api"
#   cidr = "10.1.0.0/16"

#   azs             = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
#   private_subnets = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
#   public_subnets  = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]

#   enable_nat_gateway = true

#   tags = {
#     Terraform = "true"
#     Environment = "uat"
#   }
# }

## Output for DEV env ##
output "database_subnets_ids" {
  value = "${module.vpc.database_subnets}"
}

output "security_group_id" {
  value = "${module.vpc.default_security_group_id}"
}

output "private_subnets_ids" {
  value = "${module.vpc.private_subnets}"
}

output "public_subnets_ids" {
  value = "${module.vpc.public_subnets}"
}

output "vpc_id" {
  value = "${module.vpc.vpc_id}"
}
