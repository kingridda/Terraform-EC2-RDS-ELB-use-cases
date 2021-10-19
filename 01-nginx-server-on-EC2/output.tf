
output "aws_instance_public_dns" {
  value = aws_instance.myserver.public_dns
}