data "aws_ami" "this" {
  most_recent = true

  filter {
    name = "name"
    values = [
    "amzn2-ami-*"]
  }

  filter {
    name = "virtualization-type"
    values = [
    "hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  owners = [
    "amazon"
  ]
}


resource "aws_launch_template" "this" {
//  name                   = ""
  description            = "Managed by Terraform."
  image_id      = data.aws_ami.this.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.this.key_name
  vpc_security_group_ids = var.security_groups_list

  update_default_version = true

  credit_specification {
    cpu_credits = "standard"
  }
  monitoring {
    enabled = false
  }

  tag_specifications {
    resource_type = "instance"
    tags          = var.tags
  }
  tag_specifications {
    resource_type = "volume"
    tags          = var.tags
  }
  user_data = filebase64("${path.module}/user_data.sh")
  tags = var.tags
}

resource "aws_autoscaling_group" "this" {
//  name     = ""
  max_size = 2
  min_size = 1
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  health_check_type   = "EC2"
  vpc_zone_identifier = var.subnets_ids_list
  tags                = var.tags
}

resource "aws_key_pair" "this" {
  key_name_prefix = "cluster"
  public_key      = var.public_key
}