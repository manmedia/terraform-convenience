output "target_group_arn_value" {
  value = module.ec2_target_group.target_group_arn
}

output "load_balancer_arn" {
  value = aws_alb.my_test_elb_http.arn
}