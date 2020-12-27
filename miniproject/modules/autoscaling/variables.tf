variable "tags" { type = map(any) }

variable "instance_type" { type = string }

variable "security_groups_list" { type = list(string) }

variable "subnets_ids_list" { type = list(string) }

variable "public_key" { type = string }