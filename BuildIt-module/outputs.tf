output "frontend_instance_ip" {
  value = aws_instance.frontend_instance.public_ip
}

output "server_instance_ip" {
  value = aws_instance.server_instance.private_ip
}

output "api_instance_ip" {
  value = aws_instance.api_instance.private_ip
}


output "frontend_SG" {
  value = aws_security_group.frontend_SG.id
}

output "server_SG" {
  value = aws_security_group.server_SG.id
}