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
  subnet_ids_list   = module.vpc.private_networks
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

### JUMPHOST FOR TROUBLESHOOTING
data "aws_security_group" "default" {
  vpc_id = module.vpc.vpc_id
  name   = "default"
}
resource "aws_instance" "jumphost" {
  ami                    = "ami-0885b1f6bd170450c" //Ubuntu AMI provided by AWS
  instance_type          = "t2.micro"
  subnet_id              = module.vpc.public_networks[0]
  vpc_security_group_ids = [data.aws_security_group.default.id, aws_security_group.ssh.id]
  key_name               = "hillel"
  tags                   = merge(local.common_tags,{ Name = "JUMPSERVER" })
}
resource "aws_security_group" "ssh" {
  vpc_id      = module.vpc.vpc_id
  name_prefix = "test"
  egress {
    from_port   = 0
    protocol    = "-1"
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    protocol    = "TCP"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
}