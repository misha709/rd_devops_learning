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
    Name    = "mi-rd-vpc"
    project = var.project_tag
  }
}

resource "aws_subnet" "mi-public-subnet" {
  vpc_id     = aws_vpc.mi-vpc.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name    = "mi-rd-public-subnet"
    project = var.project_tag
  }
}

resource "aws_subnet" "mi-private-subnet" {
  vpc_id     = aws_vpc.mi-vpc.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name    = "mi-rd-private-subnet"
    project = var.project_tag
  }
}