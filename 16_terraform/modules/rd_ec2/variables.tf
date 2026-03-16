variable "instance_type" {
  description = "EC2 instance type (e.g. t2.micro)."
  type        = string
  default     = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet ID for the instance."
  type        = string
}

variable "public_key_name" {
  description = "AWS key pair name for SSH."
  type        = string
}

variable "tags" {
  description = "Tags for the instance."
  type        = map(string)
  default     = {}
}