module "ec2_target_group" {
  source                 = "../target_group"
  alb_target_group_name  = var.target_group_name
  alb_communication_port = var.elb_forward_port
  health_check_interval  = var.elb_check_interval
  health_check_port      = var.elb_health_check_port
  health_check_timeout   = var.elb_health_check_timeout
  unhealthy_threshold    = var.elb_unhealthy_threshold
  health_check_path      = var.elb_health_check_path
  vpc_id                 = var.vpc_id
}

module "ec2_target_group_attachments" {
  for_each         = var.list_of_target_ids
  source           = "../target_group_attachments"
  target_group_arn = module.ec2_target_group.target_group_arn
  target_id        = each.key
}


resource "aws_alb" "my_test_elb_http" {

  subnets         = var.subnets_for_elb
  security_groups = var.security_groups_for_elb
  name            = var.load_balancer_name


  tags = {
    name = var.load_balancer_name
  }

}

resource "aws_alb_listener" "my_test_elb_forward_listener" {

  load_balancer_arn = aws_alb.my_test_elb_http.arn
  port              = var.elb_listener_port
  default_action {
    type             = "forward"
    target_group_arn = module.ec2_target_group.target_group_arn
  }

}
