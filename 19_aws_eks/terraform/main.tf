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

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "mi-rd-eks-cluster"
  kubernetes_version = "1.33"

  vpc_id     = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.public.ids

  eks_managed_node_groups = {
    workers = {
      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 2
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
  }
}
