output "instance_id" {
  description = "EC2 instance ID."
  value       = aws_instance.mi_amazon_instance.id
}

output "public_ip" {
  description = "Instance public IP (for SSH/HTTP)."
  value       = aws_instance.mi_amazon_instance.public_ip
}

output "instance_type" {
  description = "Launched instance type (e.g. t2.micro)."
  value       = aws_instance.mi_amazon_instance.instance_type
}