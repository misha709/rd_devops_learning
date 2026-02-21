terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "mi-vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "mi-rd-vpc"
    project = var.project_tag
  }
}