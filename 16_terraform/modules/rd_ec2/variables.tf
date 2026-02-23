variable "instance_type" {
  description = "Instance type"
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet id"
  type = string
}

variable "public_key_name" {
  description = "Public key name for the instance"
  type = string
}

variable "tags" {
  description = "Tags"
  type = map(string)
  default = {}
}