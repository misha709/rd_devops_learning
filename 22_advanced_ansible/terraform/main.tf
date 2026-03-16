data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

resource "aws_security_group" "web_servers" {
  name        = "rd-ansible-lab-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "rd-ansible-lab-sg"
    Project = var.project_tag
  }
}

resource "aws_key_pair" "key" {
  key_name   = "rd-ansible-lab-key"
  public_key = file("../.ssh/rd-web-key.pub")
}

resource "aws_instance" "web" {
  count         = 3
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  key_name               = aws_key_pair.key.key_name
  vpc_security_group_ids = [aws_security_group.web_servers.id]

  tags = {
    Name    = "rd-ansible-lab-${count.index + 1}"
    Project = var.project_tag
    Ansible = "true"
    Role    = "web"
    Environment = "development"
  }
}