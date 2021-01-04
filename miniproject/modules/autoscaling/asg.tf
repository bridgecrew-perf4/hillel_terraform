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

data "aws_security_group" "default_sg" {
  vpc_id = var.vpc_id
  name   = "default"
}


resource "aws_launch_template" "this" {
  name_prefix            = "hillel"
  image_id               = data.aws_ami.this.image_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.this.key_name
  vpc_security_group_ids = [data.aws_security_group.default_sg.id]

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
  tags      = var.tags
}

resource "aws_autoscaling_group" "this" {
  name_prefix = "hillel"

  target_group_arns = var.target_group_arns

  max_size = 4
  min_size = 2
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  health_check_type         = "ELB" //change to ELB on the next class
  health_check_grace_period = 120
  vpc_zone_identifier       = var.subnet_ids_list
}

resource "aws_key_pair" "this" {
  key_name_prefix = "hillel"
  public_key      = var.public_key
}