variable "instance_type" {
  description = "Instance type"
  type = string
  default = "t2.micro"
}

variable "subnet_id" {
  description = "Subnet id"
  type = string
}

variable "public_key_path" {
  description = "Path to public key"
  type = string
}

variable "tags" {
  description = "Tags"
  type = map(string)
  default = {}
}