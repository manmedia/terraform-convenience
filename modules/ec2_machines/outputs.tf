output "instance_id" {
  value = aws_instance.my-sample-webapp-ec2.id # splat expression
}

output "availability_zone" {
  value = aws_instance.my-sample-webapp-ec2.availability_zone # splat expression
}