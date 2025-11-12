variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "ami_id" {
  description = "Mock AMI ID (for LocalStack only)"
  default     = "ami-12345678"
}

