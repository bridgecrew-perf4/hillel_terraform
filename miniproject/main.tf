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

//module "autoscaling" {
//  source = "./modules/autoscaling"
//}
//
//module "application_load_balancer" {
//  source = "./modules/alb"
//}
//
//output "web_endpoint" {
//  value = ""
//}

output "vpc_info" {
  value = {
    public_networks  = module.vpc.public_networks
    private_networks = module.vpc.private_networks
    vpc_id           = module.vpc.vpc_id
  }
}