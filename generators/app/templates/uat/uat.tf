module "uat" {
  source="../modules"

  vpc_config = {
    env              = "uat"
    name             = "uat-vpc-beanstalk-demo-api"
    azs              = ["ap-southeast-2a", "ap-southeast-2b", "ap-southeast-2c"]
    private_subnets  = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
    public_subnets   = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
    database_subnets = ["10.1.21.0/24", "10.1.22.0/24"]
  }

  db_config = {
    instance_type = "db.t2.micro"
  }
}
