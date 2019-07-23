
variable "vpc_id" {}
variable "subnet_id" {
}

variable "env" {
  default = "dev"
}


variable "instance_count" {
  default = <%= jumpbox %>
}

variable "security_group_ids"{
  type = "list"
}