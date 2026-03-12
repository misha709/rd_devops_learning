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

resource "aws_vpc" "rd_mi_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name    = "rd-mi-vpc"
    Project = var.project_tag
  }
}

resource "aws_subnet" "rd_mi_public_subnet_a" {
  vpc_id     = aws_vpc.rd_mi_vpc.id
  cidr_block = "10.0.1.0/24"
  

  tags = {
    Name    = "rd-mi-public-subnet-a"
    Project = var.project_tag
  }
}
resource "aws_subnet" "rd_mi_public_subnet_b" {
  vpc_id     = aws_vpc.rd_mi_vpc.id
  cidr_block = "10.0.2.0/24"
  

  tags = {
    Name    = "rd-mi-public-subnet-b"
    Project = var.project_tag
  }
}

resource "aws_internet_gateway" "rd_mi_internet_gateway" {
  vpc_id = aws_vpc.rd_mi_vpc.id

  tags = {
    Name    = "rd-mi-internet-gateway"
    Project = var.project_tag
  }
}

resource "aws_route_table" "rd_mi_public_rt" {
  vpc_id = aws_vpc.rd_mi_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.rd_mi_internet_gateway.id
  }

  tags = {
    Name    = "rd-mi-public-rt"
    Project = var.project_tag
  }
}

resource "aws_route_table_association" "rd_mi_public_subnet_a_assoc" {
  subnet_id      = aws_subnet.rd_mi_public_subnet_a.id
  route_table_id = aws_route_table.rd_mi_public_rt.id
}

resource "aws_route_table_association" "rd_mi_public_subnet_b_assoc" {
  subnet_id      = aws_subnet.rd_mi_public_subnet_b.id
  route_table_id = aws_route_table.rd_mi_public_rt.id
}


# module "rd-mi-eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 21.0"

#   name               = "mi-rd-eks-cluster"
#   kubernetes_version = "1.35"

#   vpc_id     = aws_vpc.rd_mi_vpc.id
#   subnet_ids = [aws_subnet.rd_mi_public_subnet_a.id, aws_subnet.rd_mi_public_subnet_b.id]

#   eks_managed_node_groups = {
#     workers = {
#       instance_types = ["t3.medium"]

#       min_size     = 2
#       max_size     = 2
#       desired_size = 2
#     }
#   }

#   tags = {
#     Name    = "rd-mi-eks-cluster"
#     Project = var.project_tag
#   }
# }
