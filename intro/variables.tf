variable "ami_id" {
  type        = string
  default     = "ami-03156384f702d4eaf"
  description = "ID of the AMI in a format 'ami-1z2x3c4v5b6m'"
  // Homework — add validation
  // https://www.terraform.io/docs/configuration/variables.html#custom-validation-rules
}
variable "eip_attach" {
  type        = bool
  default     = false
  description = "Selector for ElasticIP: true == create and attach"
}