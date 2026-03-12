output "vpc_id" {
  value = aws_vpc.rd_mi_vpc.id
}

output "cidr_block" {
  value = aws_vpc.rd_mi_vpc.cidr_block
}

output "subnets" {
  value = aws_subnet.subnet
}

output "internet_gateway" {
  value = aws_internet_gateway.rd_mi_internet_gateway
}

output "route_table" {
  value = aws_route_table.rd_mi_public_rt
}