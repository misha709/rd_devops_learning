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

resource "aws_internet_gateway" "mi-gateway" {
  vpc_id = aws_vpc.mi-vpc.id

  tags = {
    Name    = "mi-gateway"
    project = var.project_tag
  }
}

resource "aws_route_table" "mi-public-rt" {
  vpc_id = aws_vpc.mi-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.mi-gateway.id
  }

  tags = {
    Name    = "mi-rd-public-rt"
    project = var.project_tag
  }
}

resource "aws_route_table_association" "mi-public-subnet-assoc" {
  subnet_id      = aws_subnet.mi-public-subnet.id
  route_table_id = aws_route_table.mi-public-rt.id
}