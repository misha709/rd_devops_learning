output "vpc" {
  description = "VPC ARN and CIDR block."
  value = {
    arn        = module.rd_vpc.arn
    cidr_block = module.rd_vpc.cidr_block
  }
}

output "subnet_id" {
  description = "Subnet ID."
  value       = module.rd_subnet.id
}

output "ec2_instance_1" {
  description = "EC2 instance 1 ID, public IP, and type."
  value = {
    id            = module.ec2_instance_1.instance_id
    public_ip     = module.ec2_instance_1.public_ip
    instance_type = module.ec2_instance_1.instance_type
  }
}

output "ec2_instance_2" {
  description = "EC2 instance 2 ID, public IP, and type."
  value = {
    id            = module.ec2_instance_2.instance_id
    public_ip     = module.ec2_instance_2.public_ip
    instance_type = module.ec2_instance_2.instance_type
  }
}

output "bucket" {
  description = "S3 bucket ID and ARN."
  value = {
    id  = aws_s3_bucket.bucket.id
    arn = aws_s3_bucket.bucket.arn
  }
}
