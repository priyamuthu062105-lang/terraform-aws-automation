output "vpc_id" {
  description = "ID of the Project-03 VPC"
  value       = module.networking.vpc_id
}

output "ec2_instance_id" {
  description = "ID of the EC2 web server"
  value       = module.compute.instance_id
}

output "elastic_ip" {
  description = "Elastic IP of the EC2 web server"
  value       = module.compute.elastic_ip
}

output "application_url" {
  description = "URL of the Project-03 web application"
  value       = module.compute.application_url
}

output "s3_bucket_name" {
  description = "Name of the Project-03 S3 bucket"
  value       = aws_s3_bucket.project_bucket.id
}

output "iam_role_name" {
  description = "IAM role attached to the EC2 instance"
  value       = module.compute.iam_role_name
}
