variable "vpc_id" {
  description = "VPC id"
  type = string
}

variable "cidr_block" {
  description = "CIDR block"
  type = string
}

variable "tags" {
  description = "Tags"
  type = map(string)
  default = {}
}
