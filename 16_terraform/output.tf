output "vpc" {
  value = {
    arn        = module.rd_vpc.arn
    cidr_block = module.rd_vpc.cidr_block
  }
}