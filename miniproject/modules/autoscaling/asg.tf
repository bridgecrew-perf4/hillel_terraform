data "aws_ami" "ami_ecs_optimized" {
  most_recent = true

  filter {
    name = "name"
    values = [
      "amzn2-ami-ecs-*"]
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
  name = ""
  description            = "Managed by Terraform."
  update_default_version = true
  credit_specification {
    cpu_credits = "standard" # disable T3-Unlimited
  }
  iam_instance_profile {
    arn = aws_iam_instance_profile.this.arn
  }
  image_id      = data.aws_ami.ami_ecs_optimized.image_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.this.key_name
  monitoring {
    enabled = false
  }
  vpc_security_group_ids = var.ec2_sg_list
  tag_specifications {
    resource_type = "instance"
    tags = merge(
    {
      "Name" = "ecs-${var.cluster_name}"
    },
    "${var.tags}"
    )
  }
  tag_specifications {
    resource_type = "volume"
    tags          = merge({ "Name" = "root volume" }, var.tags)
  }
  user_data = base64encode(templatefile("${path.module}/user-data.tmpl", { cluster_name = var.cluster_name }))
  tags      = var.tags
}

resource "aws_autoscaling_group" "asg_ecs_cluster" {
  name     = "ecs-${var.cluster_name}"
  max_size = 11
  min_size = 1
  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }
  health_check_type   = "EC2"
  vpc_zone_identifier = var.subnets_id_list
}

resource "aws_key_pair" "this" {
  key_name_prefix   = "ecs-"
  public_key = var.public_key
}