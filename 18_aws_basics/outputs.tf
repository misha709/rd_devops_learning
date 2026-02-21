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
