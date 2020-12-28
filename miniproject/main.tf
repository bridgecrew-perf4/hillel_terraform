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
  source            = "./modules/autoscaling"
  instance_type     = "t2.micro"
  subnet_ids_list   = module.vpc.public_networks
  vpc_id            = module.vpc.vpc_id
  tags              = local.common_tags
  target_group_arns = [module.load_balancer.target_group_arns]
}

module "load_balancer" {
  source          = "./modules/load_balancer"
  subnet_ids_list = module.vpc.public_networks
  tags            = local.common_tags
  vpc_id          = module.vpc.vpc_id
}
