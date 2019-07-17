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