output "id" {
  description = "VPC ID for attaching subnets and resources."
  value       = aws_vpc.vpc.id
}

output "arn" {
  description = "VPC ARN for IAM or cross-account use."
  value       = aws_vpc.vpc.arn
}

output "cidr_block" {
  description = "VPC CIDR block (e.g. 10.0.0.0/16)."
  value       = aws_vpc.vpc.cidr_block
}