output "ip" {
  value       = aws_instance.server.public_ip
  description = "aws ec2 public ip"
}