output "ip" {
  value       = aws_instance.server.public_ip
  description = "AWS EC2 public IP"
}



output "dns" {
  value = aws_eip.lb.public_ip
  description="aws eip dns"
}