##########################################
# Terraform Configuration File (main.tf)
# Project: Terraform + Ansible + Jenkins Pipeline
# Author: Hemanth Kumar Chikkala
##########################################

terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}

##########################################
# Provider Configuration
##########################################
provider "aws" {
  region  = var.aws_region
  access_key = "test"
  secret_key = "test"

  # Use LocalStack endpoint for S3
  endpoints {
    s3 = "http://localhost:4566"
  }

  # Skip real AWS checks
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
}



##########################################
# Random ID for Unique Bucket Name
##########################################
resource "random_id" "bucket_suffix" {
  byte_length = 4
}

##########################################
# S3 Bucket Resource
##########################################
resource "aws_s3_bucket" "local_bucket" {
  bucket        = "hemanth-localstack-demo-${random_id.bucket_suffix.hex}"
  force_destroy = true

  tags = {
    Name    = "LocalStack-Demo-Bucket"
    Project = "Terraform-Ansible-Jenkins"
  }
}

##########################################
# EC2 Instance (For Local Testing)
##########################################
resource "aws_instance" "local_vm" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name    = "LocalStack-EC2"
    Project = "Terraform-Ansible-Jenkins"
  }

  provisioner "local-exec" {
    command = <<EOT
      echo "Running Ansible Playbook..."
      ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini playbook.yml
    EOT
  }
}

##########################################
# Outputs
##########################################
output "bucket_name" {
  description = "The name of the S3 bucket created"
  value       = aws_s3_bucket.local_bucket.bucket
}

output "instance_id" {
  description = "The ID of the EC2 instance created"
  value       = aws_instance.local_vm.id
}
