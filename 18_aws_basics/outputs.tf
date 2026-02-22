output "vpc" {
  description = "VPC attributes"
  value = {
    id         = aws_vpc.mi-vpc.id
    cidr_block = aws_vpc.mi-vpc.cidr_block
  }
}

output "subnets" {
  description = "Subnet IDs and CIDR blocks"
  value = {
    public = {
      id         = aws_subnet.mi-public-subnet.id
      cidr_block = aws_subnet.mi-public-subnet.cidr_block
    }
    private = {
      id         = aws_subnet.mi-private-subnet.id
      cidr_block = aws_subnet.mi-private-subnet.cidr_block
    }
  }
}

output "networking" {
  description = "Internet gateway and route table IDs"
  value = {
    internet_gateway_id = aws_internet_gateway.mi-gateway.id
    public_route_table_id = aws_route_table.mi-public-rt.id
  }
}

output "ec2_instance" {
  description = "EC2 instance details"
  value = {
    instance_id   = aws_instance.mi_amazon_instance.id
    elastic_ip    = aws_eip.mi-ec2-eip.public_ip
    public_ip     = aws_instance.mi_amazon_instance.public_ip
    ami_id        = aws_instance.mi_amazon_instance.ami
    instance_type = aws_instance.mi_amazon_instance.instance_type
  }
}

output "security_group" {
  description = "Security Group details"
  value = {
    id   = aws_security_group.mi-ec2-sg.id
    name = aws_security_group.mi-ec2-sg.name
  }
}

output "elastic_ip" {
  description = "Elastic IP details"
  value = {
    id         = aws_eip.mi-ec2-eip.id
    public_ip  = aws_eip.mi-ec2-eip.public_ip
    allocation_id = aws_eip.mi-ec2-eip.allocation_id
  }
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh -i mi-rd-ec2-key ec2-user@${aws_eip.mi-ec2-eip.public_ip}"
}
