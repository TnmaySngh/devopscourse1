
# EC2 Instance Public IP
output "ec2_public_ip" {
  description = "Public IP address of EC2 instance"
  value       = { for name, inst in aws_instance.web : name => inst.public_ip }
}

# EC2 Instance Public DNS
output "ec2_public_dns" {
  description = "Public DNS of EC2 instance"
  value       = { for name, inst in aws_instance.web : name => inst.public_dns }
}
