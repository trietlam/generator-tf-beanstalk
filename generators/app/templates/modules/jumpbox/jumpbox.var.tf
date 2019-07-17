
variable "vpc_id" {}
variable "subnet_id" {
}

variable "instance_count" {
  default = <%= jumpbox %>
}

variable "security_group_ids"{
  type = "list"
}