variable "vpc_config" {
  type=object({
    env = string
    name = string
    azs = list
    private_subnets = list
    public_subnets = list
    database_subnets = list
  })
}

variable "env" {
  default = "dev"
}

variable "db_config" {
  type=object({
    instance_type = string
  })
}

variable "eb_config" {
  type=object({
    env = string
  })
}
