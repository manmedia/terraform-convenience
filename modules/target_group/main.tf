# Define a target group for elb
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group
# see note for identical functionality

resource "aws_alb_target_group" "my-alb-target-group" {
  name     = var.alb_target_group_name
  port     = var.alb_communication_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  # default target type is always "instance"

  health_check {
    enabled             = true
    interval            = var.health_check_interval # seconds
    path                = var.health_check_path
    port                = var.health_check_port
    timeout             = var.health_check_timeout # seconds
    unhealthy_threshold = var.unhealthy_threshold
  }

}