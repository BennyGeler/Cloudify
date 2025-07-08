# הפלט עבור ה-Security Group
output "security_group_id" {
  description = "The ID of the security group for the web server"
  value       = aws_security_group.web_sg.id
}

# הפלט עבור ה-EBS Volume
output "ebs_volume_id" {
  description = "The ID of the EBS volume attached to the EC2 instance"
  value       = aws_ebs_volume.web_volume.id
}
