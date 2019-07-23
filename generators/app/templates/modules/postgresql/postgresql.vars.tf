variable "vpc_security_group_ids" {
  type = "list"
}

variable "vpc_subnets" {
  type = "list"
}

variable "instance_type" {
  description = "What kind of servers to run (e.g. t2.large)"
  default = "db.t2.micro"
}