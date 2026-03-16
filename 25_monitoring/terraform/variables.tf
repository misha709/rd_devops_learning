variable "aws_region" {
  description = "AWS region for resources"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "monitoring-lab"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.10.0.0/16"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  type        = string
  default     = "10.10.10.0/24"
}

variable "availability_zone" {
  description = "Availability zone for subnet"
  type        = string
  default     = "us-east-1a"
}

variable "key_name" {
  description = "Name of the SSH key pair"
  type        = string
  default     = "monitor-key"
}

variable "public_key_path" {
  description = "Path to the SSH public key file"
  type        = string
  default     = "../.ssh/monitor-key.pub"
}

variable "my_ip" {
  description = "Your IP address for SSH access (CIDR format)"
  type        = string
}

variable "monitoring_instance_type" {
  description = "EC2 instance type for monitoring server"
  type        = string
  default     = "t3.small"
}

variable "web_instance_type" {
  description = "EC2 instance type for web server"
  type        = string
  default     = "t3.micro"
}
