output "instance_id" {
  value = aws_instance.my_sample_webapp_ec2.id # splat expression
}

output "availability_zone" {
  value = aws_instance.my_sample_webapp_ec2.availability_zone # splat expression
}