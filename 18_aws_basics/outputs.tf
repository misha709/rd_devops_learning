output "vpc_id" {
  description = "ID of the VPC"
  value = aws_vpc.mi-vpc.id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value = aws_vpc.mi-vpc.cidr_block
}