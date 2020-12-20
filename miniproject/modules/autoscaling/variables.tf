variable "tags" { type = map(any) }

variable "instance_type" { type = string }

variable "ec2_sg_list" { type = list(string) }

variable "subnets_id_list" { type = list(string) }

variable "public_key" { type = string }