locals {
  common_tags = {
    Purpose = "Education"
    Project = "Hillel"
    Class   = "Class 17"
  }
}

resource "aws_instance" "this" {
  ami                    = var.ami_id    // Homework: change to a variable (type string)
  instance_type          = "t2.micro"                 // Homework: change to a variable (type string)
  vpc_security_group_ids = [aws_security_group.this.id]

  // Homework: define keypair via variable (type string) with default value (your own public key)
  //           https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair

  tags = local.common_tags
}

resource "aws_eip" "this" {
  count    = (var.eip_attach ? 1 : 0)
  instance = aws_instance.this.id
  tags     = local.common_tags
}

resource "aws_security_group" "this" {
  name_prefix = "temporary"
  description = "Temporary SG for hillel class 17"
  tags        = local.common_tags

  egress { // allow outgoing traffic to anywhere
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // Homework: get 'default' VPC id using data source and define VPC for security group explicitly
  // https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc

}

resource "aws_security_group_rule" "SSH" {
  description       = "Allow SSH from anywhere. It is insecure but we are brave!"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
resource "aws_security_group_rule" "HTTP" {
  description       = "Allow plain HTTP from anywhere"
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}
resource "aws_security_group_rule" "HTTPS" {
  description       = "Allow secured HTTPS from anywhere"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.this.id
}


output "instance_pub_ip" {
  value     = aws_instance.this.public_ip
  sensitive = false
}
output "instance_pub_dns" {
  value = aws_instance.this.public_dns
}