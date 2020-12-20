//project main file

locals {
  common_tags = {
    Purpose = "Education"
    Project = "Hillel"
  }
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  tags = local.common_tags
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