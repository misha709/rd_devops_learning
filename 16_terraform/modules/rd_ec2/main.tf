data "aws_ami" "amazon2" {
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
  ami                         = data.aws_ami.amazon2.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = var.public_key_name
  associate_public_ip_address = true

  tags = var.tags
}