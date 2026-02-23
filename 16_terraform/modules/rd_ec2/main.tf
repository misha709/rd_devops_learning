
resource "aws_key_pair" "mi-ec2-key" {
  key_name   = "mi-rd-ec2-key"
  public_key = var.public_key_path

  tags = {
    Name    = "mi-rd-ec2-key"
  }
}

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
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.mi-ec2-key.key_name
  associate_public_ip_address = true

  tags = var.tags
}