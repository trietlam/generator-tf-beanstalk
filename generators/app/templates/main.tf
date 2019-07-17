
# Terraform will use $AWS_ACCESS_KEY_ID and $AWS_SECRET_ACCESS_KEY if below value not set
provider "aws" {
  profile    = "${var.profile}"
  region     = "${var.region}"
}

module "dev" {
  source="./dev"

  app_name = "${var.app_name}"
  region   = "${var.region}"
}
