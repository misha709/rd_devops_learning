variable "cidr_block" {
  description = "Block"
  type        = string
}

variable "tags" {
  description = "Tags"
  type = map(string)
  default = {}
}