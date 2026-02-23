output "vpc" {
  description = "VPC ARN and CIDR block."
  value = {
    arn        = module.rd_vpc.arn
    cidr_block = module.rd_vpc.cidr_block
  }
}