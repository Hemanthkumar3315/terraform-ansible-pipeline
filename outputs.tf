output "instance_id" {
  value = aws_instance.local_vm.id
}

output "bucket_name" {
  value = aws_s3_bucket.local_bucket.bucket
}

