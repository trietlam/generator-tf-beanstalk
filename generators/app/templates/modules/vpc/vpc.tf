module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.7.0"

  name = "${var.vpc_config.name}"
  cidr = "10.0.0.0/16"

  azs              = "${var.vpc_config.azs}"
  private_subnets  = "${var.vpc_config.private_subnets}"
  public_subnets   = "${var.vpc_config.public_subnets}"
  database_subnets = "${var.vpc_config.database_subnets}"

  enable_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "${var.vpc_config.env}"
  }
}

## Output ##
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
