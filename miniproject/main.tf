//project main file
provider "aws" {
  profile = "hillel"
  region  = "us-east-1"
}

locals {
  common_tags = {
    Purpose = "Education"
    Project = "Hillel"
  }
}

module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  tags     = local.common_tags
}

module "autoscaling" {
  source = "./modules/autoscaling"
  instance_type = "t2.micro"
  subnet_ids_list = module.vpc.public_networks //will change this to private sn on the next class
  vpc_id = module.vpc.vpc_id
  tags = local.common_tags
}
//
//module "application_load_balancer" {
//  source = "./modules/alb"
//}
//
//output "web_endpoint" {
//  value = ""
//}

