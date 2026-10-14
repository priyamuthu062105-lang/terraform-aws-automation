# AWS Infrastructure Automation Using Terraform and GitHub Actions

## Project-03

### Project Overview
This project demonstrates how to automate AWS infrastructure provisioning using Terraform and GitHub Actions. Terraform is used to create cloud resources, while GitHub Actions automates configuration validation, infrastructure planning, and deployment.

### Technologies Used
- Amazon Web Services (AWS)
- Terraform
- GitHub Actions
- Git and GitHub
- Ubuntu Linux
- Nginx

### AWS Services Used
- Amazon VPC
- Amazon EC2
- Amazon S3
- AWS IAM
- Elastic IP
- Internet Gateway
- Security Groups

### Project Architecture
GitHub Repository
       |
       v
GitHub Actions
       |
       v
Terraform Plan and Apply
       |
       v
AWS Infrastructure
       |
       +-- VPC
       |    +-- Public Subnets
       |    +-- Internet Gateway
       |    +-- Route Tables
       |    +-- Security Groups
       |
       +-- EC2 Web Server (Nginx)
       +-- Elastic IP
       +-- S3 Bucket
       +-- IAM Role

Terraform state is stored remotely in Amazon S3.

### Terraform Project Structure
```text
terraform-aws-automation/
├── .github/
│   └── workflows/
│       ├── terraform.yml
│       └── terraform-apply.yml
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── backend.tf
├── main.tf
├── providers.tf
├── variables.tf
├── outputs.tf
├── s3.tf
├── .gitignore
├── .terraform.lock.hcl
└── README.md
```

### Terraform Modules
The networking module creates the VPC, public subnets, route tables, internet gateway, and security group.

The compute module provisions the EC2 web server, Elastic IP, and IAM instance role.

### Remote State Configuration
Terraform uses an Amazon S3 backend to store its state remotely.

- State bucket: project03-tfstate-359013545320
- State key: dev/terraform.tfstate
- AWS region: ap-south-1

Bucket versioning is enabled to help recover previous state versions. Terraform uses the configured remote-state locking mechanism to prevent concurrent state changes.

### GitHub Actions CI/CD
Two workflows are configured:

1. Terraform Format and Validate
   - Checks Terraform formatting
   - Authenticates to AWS using GitHub OIDC
   - Initializes and validates Terraform
   - Generates a Terraform execution plan
   - Uploads the plan as a GitHub Actions artifact

2. Terraform Apply - Production
   - Runs through a manually triggered workflow
   - Uses the production GitHub environment
   - Requires approval before deployment
   - Generates and applies a Terraform plan
   - Displays infrastructure outputs
   - Validates the deployed web application

### Authentication and Security
GitHub Actions uses OpenID Connect (OIDC) to assume the GitHubActions-Project03-Role IAM role. This avoids storing long-term AWS access keys in GitHub.

The repository excludes local Terraform directories, state files, and variable files containing potentially sensitive values.

### Deployment Steps
1. Clone the GitHub repository.
2. Install Terraform and configure authorized AWS credentials.
3. Supply the required Terraform input variables, including a suitable Ubuntu AMI ID.
4. Run terraform init.
5. Run terraform fmt -check -recursive.
6. Run terraform validate.
7. Run terraform plan.
8. Review the plan and run terraform apply.
9. Verify the EC2 web application.
10. Use the GitHub Actions workflows for automated planning and approved deployment.

### Terraform Commands
```bash
terraform init
terraform fmt -check -recursive
terraform validate
terraform plan
terraform apply
terraform output
```

### Application URL
http://13.204.246.49

This HTTP address is a demonstration endpoint and may become unavailable if the AWS infrastructure is stopped or destroyed. HTTPS is a recommended future improvement.

### GitHub Repository
https://github.com/priyamuthu062105-lang/terraform-aws-automation

### Project Results
- AWS infrastructure provisioned successfully with Terraform
- Modular Terraform configuration implemented
- Remote state stored in Amazon S3
- GitHub Actions Terraform planning completed successfully
- Production apply workflow completed successfully
- EC2-hosted Nginx application verified through its public IP address

### Conclusion
This project helped demonstrate infrastructure as code, cloud resource provisioning, reusable Terraform modules, remote state management, and CI/CD automation using GitHub Actions. It also demonstrates secure GitHub-to-AWS authentication using OIDC.

### Future Improvements
- Configure HTTPS with a domain name and TLS certificate
- Add automated security checks for Terraform
- Improve monitoring and alerting
- Apply least-privilege IAM permissions
