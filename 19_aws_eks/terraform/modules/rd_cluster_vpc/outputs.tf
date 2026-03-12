output "arn" {
  value = aws_vpc.vpc.arn
}

output "cidr_block" {
  value = aws_vpc.vpc.cidr_block
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