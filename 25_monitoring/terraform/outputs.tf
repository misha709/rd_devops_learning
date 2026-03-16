output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.monitoring_vpc.id
}

output "public_subnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.public_subnet.id
}

output "monitoring_server_public_ip" {
  description = "Public IP address of monitoring server"
  value       = aws_instance.monitoring_server.public_ip
}

output "monitoring_server_private_ip" {
  description = "Private IP address of monitoring server"
  value       = aws_instance.monitoring_server.private_ip
}

output "web_server_public_ip" {
  description = "Public IP address of web server"
  value       = aws_instance.web_server.public_ip
}

output "web_server_private_ip" {
  description = "Private IP address of web server"
  value       = aws_instance.web_server.private_ip
}

output "prometheus_url" {
  description = "Prometheus UI URL"
  value       = "http://${aws_instance.monitoring_server.public_ip}:9090"
}

output "grafana_url" {
  description = "Grafana UI URL"
  value       = "http://${aws_instance.monitoring_server.public_ip}:3000"
}

output "nginx_url" {
  description = "Nginx web server URL"
  value       = "http://${aws_instance.web_server.public_ip}"
}

output "ssh_monitoring_server" {
  description = "SSH command for monitoring server"
  value       = "ssh -i .ssh/monitor-key ubuntu@${aws_instance.monitoring_server.public_ip}"
}

output "ssh_web_server" {
  description = "SSH command for web server"
  value       = "ssh -i .ssh/monitor-key ubuntu@${aws_instance.web_server.public_ip}"
}
