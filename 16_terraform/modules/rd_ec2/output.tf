output "instance_id" {
  value = aws_instance.mi_amazon_instance.id
}

output "public_ip" {
  value = aws_instance.mi_amazon_instance.public_ip
}

output "instance_type" {
  value = aws_instance.mi_amazon_instance.instance_type
}