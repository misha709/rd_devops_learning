output "web_servers_public_ips" {
  description = "Public IP addresses of web servers"
  value       = aws_instance.web[*].public_ip
}

output "ssh_commands" {
  description = "SSH commands to connect to servers"
  value       = [for ip in aws_instance.web[*].public_ip : "ssh -i ../.ssh/rd-web-key ubuntu@${ip}"]
}