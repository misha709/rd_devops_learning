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

resource "aws_security_group" "mi-ec2-sg" {
  name        = "mi-rd-ec2-sg"
  description = "Security group for EC2 instance - allows SSH and HTTP access"
  vpc_id      = aws_vpc.mi-vpc.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "mi-rd-ec2-sg"
    project = var.project_tag
  }
}

resource "aws_key_pair" "mi-ec2-key" {
  key_name   = "mi-rd-ec2-key"
  public_key = file("${path.module}/mi-rd-ec2-key.pub")

  tags = {
    Name    = "mi-rd-ec2-key"
    project = var.project_tag
  }
}

data "aws_ami" "amazon" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_instance" "mi_amazon_instance" {
  ami                         = data.aws_ami.amazon.id
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.mi-public-subnet.id
  vpc_security_group_ids      = [aws_security_group.mi-ec2-sg.id]
  key_name                    = aws_key_pair.mi-ec2-key.key_name
  associate_public_ip_address = true

  tags = {
    Name    = "mi-rd-amazon-instance"
    project = var.project_tag
  }
}

resource "aws_eip" "mi-ec2-eip" {
  instance = aws_instance.mi_amazon_instance.id
  domain   = "vpc"

  tags = {
    Name    = "mi-rd-ec2-eip"
    project = var.project_tag
  }

  depends_on = [aws_internet_gateway.mi-gateway]
}