variable "ami_id" {
  type        = string
  default     = "ami-0885b1f6bd170450c"
  description = "ID of the AMI in a format 'ami-1z2x3c4v5b6m'"

}
variable "eip_attach" {
  type        = bool
  default     = false
  description = "Selector for ElasticIP: true == create and attach"
}