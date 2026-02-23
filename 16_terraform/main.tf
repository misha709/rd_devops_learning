terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "rd_vpc" {
  source = "./modules/rd_vpc"

  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my-rd-vpc"
  }
}

