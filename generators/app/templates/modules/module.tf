
module "vpc" {
  source="./vpc"

  vpc_config="${var.vpc_config}"
}

module "db" {
  source="./postgresql"

  vpc_security_group_ids = "${ split(",", module.vpc.security_group_id) }"  # string to list
  vpc_subnets            = "${module.vpc.database_subnets_ids}"
}

module "jumpbox"{
  source="./jumpbox"

  vpc_id             ="${module.vpc.vpc_id}"
  subnet_id         = "${module.vpc.public_subnets_ids[0]}"
  security_group_ids = "${ split(",", module.vpc.security_group_id) }"  # string to list
  env                = "${var.env}"
}

# module "app" {
#   source="./service"

#   vpc_id="${module.vpc.vpc_id}"
#   vpc_subnets_ids="${module.vpc.public_subnets_ids}"
# }



# resource "aws_db_instance" "my_new_pipeline_db_postgresql" {
#   allocated_storage    = 20
#   storage_type         = "gp2"
#   engine               = "postgres"
#   engine_version       = "9.6.11"
#   instance_class       = "db.t2.micro"
#   name                 = "mydb"
#   username             = "dbadmin"
#   password             = "dbadminpassword"
#   parameter_group_name = "default.postgres9.6"
#   skip_final_snapshot  = true

#   tags = {
#     project = "my-new-pipeline"
#   }
# }
