# AWS Configuration Variables
variable "aws_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "aws_profile" {
  description = "The AWS CLI profile name"
  type        = string
  default     = "default"
}

# EC2 Configuration
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 instance"
  type        = string
  default     = "ami-12345678" # Replace with valid AMI if deploying to real AWS
}

# S3 Bucket Configuration
variable "bucket_name" {
  description = "Base name for the S3 bucket"
  type        = string
  default     = "hemanth-localstack-demo"
}
