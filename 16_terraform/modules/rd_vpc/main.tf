terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    tags = var.tags
}
