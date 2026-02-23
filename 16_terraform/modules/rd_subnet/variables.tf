variable "vpc_id" {
  description = "VPC ID for this subnet."
  type        = string
}

variable "cidr_block" {
  description = "Subnet CIDR (e.g. 10.0.2.0/24), within VPC range."
  type        = string
}

variable "tags" {
  description = "Tags for the subnet."
  type        = map(string)
  default     = {}
}
