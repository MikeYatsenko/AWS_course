# Output variable: Public IP address
output "public_ip" {
  value = [aws_instance.EC2Instance.public_ip]
}