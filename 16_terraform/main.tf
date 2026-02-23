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

resource "aws_key_pair" "mi-ec2-key" {
  key_name   = "mi-rd-ec2-key"
  public_key = file("${path.module}/.keys/mi-rd-ec2-key.pub")

  tags = {
    Name = "mi-rd-ec2-key"
  }
}

module "ec2_instance_1" {
  source = "./modules/rd_ec2"

  subnet_id       = module.rd_subnet.id
  public_key_name = aws_key_pair.mi-ec2-key.key_name

  tags = {
    Name : "EC2_1"
  }
}

module "ec2_instance_2" {
  source = "./modules/rd_ec2"

  instance_type   = "t3.micro"
  subnet_id       = module.rd_subnet.id
  public_key_name = aws_key_pair.mi-ec2-key.key_name

  tags = {
    Name : "EC2_2"
  }
}