module "dev" {
  source="../modules"

  env="dev"

  vpc_config = {
    env              = "dev"
    name             = "dev-${var.app_name}"
    # azs              = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
    azs              = ["${var.region}a"] // Default 1 az
    private_subnets  = ["10.0.1.0/24"]
    public_subnets   = ["10.0.101.0/24"]
    database_subnets = ["10.0.21.0/24", "10.0.22.0/24"]
  }

eb_config = {
  env = "dev"
}

  db_config = {
    instance_type = "db.t2.micro"
  }
}
