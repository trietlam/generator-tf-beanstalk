locals {
    env              = "dev"
    name             = "dev-${var.app_name}"
    # azs              = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
    # private_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
    # public_subnets   = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
    # database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]
    azs              = ["${var.region}a", "${var.region}b"] // Default 2 az
    private_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
    public_subnets   = ["10.0.101.0/24", "10.0.102.0/24"]
    database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]
}


module "dev" {
  source="../modules"

  env="dev"

  vpc_config = {
    env              = "${local.env}"
    name             = "${local.name}"
    azs              = "${local.azs}"
    private_subnets  = "${local.private_subnets}"
    public_subnets   = "${local.public_subnets}"
    database_subnets = "${local.database_subnets}"
  }

  redis_config = {
    env              = "${local.env}"
    name             = "${local.name}"
    azs              = "${local.azs}"
    private_subnets  = "${local.private_subnets}"
    public_subnets   = "${local.public_subnets}"
    database_subnets = "${local.database_subnets}"
  }

  jumpbox_config = {
    env              = "${local.env}"
    name             = "${local.name}"
    azs              = "${local.azs}"
    private_subnets  = "${local.private_subnets}"
    public_subnets   = "${local.public_subnets}"
    database_subnets = "${local.database_subnets}"
  }

  eb_config = {
    env              = "${local.env}"
  }

  db_config = {
    instance_type = "db.t2.micro"
  }
}
