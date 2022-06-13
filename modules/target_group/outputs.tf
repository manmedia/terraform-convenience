output "target_group_id" {
  value = aws_alb_target_group.my-alb-target-group.id
}

output "target_group_arn" {
  value = aws_alb_target_group.my-alb-target-group.arn
}