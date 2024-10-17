# main.tf
provider "aws" {
  region = "us-east-2"
}

module "vpc" {
  source     = "../terraform-modules/vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "development-vpc"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}
