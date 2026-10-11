output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "elastic_ip" {
  description = "Elastic IP address of the EC2 web server"
  value       = aws_eip.web.public_ip
}

output "application_url" {
  description = "URL of the web application"
  value       = "http://${aws_eip.web.public_ip}"
}

output "iam_role_name" {
  description = "Name of the IAM role attached to EC2"
  value       = aws_iam_role.ec2_role.name
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile"
  value       = aws_iam_instance_profile.ec2_profile.name
}
