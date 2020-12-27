variable "tags" { type = map(string) }

variable "instance_type" { type = string }

variable "subnet_ids_list" { type = list(string) }

variable "public_key" {
  type = string
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDfBAgbRjDC8iA2bfxoH+fjTSsMPY2g5pmywa0iGuzmjwjJ7rrdJ6tMfizxMMInV7QivrgBsedlQT9xN8khp4CgwwK41dRUtdy0s6p3lNs1C5zX209IVavMhJW5/URIo3qV4Ifi0dcuWDv+uNQ+qxgo3cJpDVJanK/UV8RB9X1ZlNez3k8cKEJReiLMuUSLArN93UoVJMENYAmWb33Toqg7nCOH57LvgJtdoGYIzjZTUjy/a6iq206KvtapRvFANZGTyG+pSGd+VXJeAED9d6Rj8BO07nfYN89as077f79wxqMq+BcGEIKsyy8d2fktK+gMM68hLM0lZFwqKFXJPgzL"
}

variable "vpc_id" {}