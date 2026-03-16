variable "cidr_block" {
  description = "VPC CIDR block (e.g. 10.0.0.0/16)."
  type        = string
}

variable "tags" {
  description = "Tags for the VPC."
  type        = map(string)
  default     = {}
}