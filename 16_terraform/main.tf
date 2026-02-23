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

module "rd_subnet" {
  source = "./modules/rd_subnet"

  vpc_id     = module.rd_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    "Name" : "my-rd-subnet"
  }
}

