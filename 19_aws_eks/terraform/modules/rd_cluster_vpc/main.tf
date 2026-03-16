terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

resource "aws_vpc" "rd_mi_vpc" {
  cidr_block = var.cidr_block

  tags = merge(var.tags, { Name = "rd-mi-vpc" })
}

resource "aws_subnet" "subnet" {
  for_each          = var.subnets
  vpc_id            = aws_vpc.rd_mi_vpc.id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = true

  tags              = merge(var.tags, { Name = "rd-mi-public-subnet-${each.key}" })
}

resource "aws_internet_gateway" "rd_mi_internet_gateway" {
  vpc_id = aws_vpc.rd_mi_vpc.id

  tags = merge(var.tags, { Name = "rd-mi-internet-gateway" })
}

resource "aws_route_table" "rd_mi_public_rt" {
  vpc_id = aws_vpc.rd_mi_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rd_mi_internet_gateway.id
  }

  tags = merge(var.tags, { Name = "rd-mi-public-rt" })
}

resource "aws_route_table_association" "rd_mi_public_subnet_assoc" {
  for_each       = var.subnets
  subnet_id      = aws_subnet.subnet[each.key].id
  route_table_id = aws_route_table.rd_mi_public_rt.id
}