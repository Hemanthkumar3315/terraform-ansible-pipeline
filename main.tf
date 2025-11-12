resource "aws_instance" "local_vm" {
  ami           = "ami-12345678"
  instance_type = "t2.micro"
  tags = {
    Name = "LocalStack-EC2"
  }

  # Trigger Ansible playbook after Terraform apply
  provisioner "local-exec" {
    command = "ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini playbook.yml"
  }
}

resource "aws_s3_bucket" "local_bucket" {
  bucket = "hemanth-localstack-demo"
  acl    = "private"
}

