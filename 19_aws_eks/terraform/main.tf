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

data "aws_availability_zones" "available" {
  state = "available"
}

module "rd_cluster_vpc" {
  source     = "./modules/rd_cluster_vpc"
  cidr_block = "10.0.0.0/16"
  subnets = {
    a = {
      cidr_block        = "10.0.1.0/24"
      availability_zone = data.aws_availability_zones.available.names[0]
    }
    b = {
      cidr_block        = "10.0.2.0/24"
      availability_zone = data.aws_availability_zones.available.names[1]
    }
  }
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
