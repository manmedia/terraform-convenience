
resource "aws_autoscaling_group" "my_asg_test" {
  name             = "my_asg_test"
  min_size         = var.autoscaling_min_instances    # this is what should be absolute minimum
  desired_capacity = var.autoscaling_desired_capacity # this is where we want to go and remain
  max_size         = var.autoscaling_max_instances    # this is what we want if we scale up

  target_group_arns = var.target_group_arns


  tags = [{
    Name      = "my_asg_test"
    Terraform = "true"
  }]

  launch_template {
    id      = var.launch_template_id
    version = var.launch_template_version
  }

  vpc_zone_identifier = var.public_subnet_list

}
# TODO consider having different policies by modularising?
resource "aws_autoscaling_policy" "my_dynamic_scaleup_policy" {
  autoscaling_group_name = aws_autoscaling_group.my_asg_test.name
  name                   = "my_dynamic_scaleup_policy"
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = 1

  cooldown = var.cooldown_period

}

resource "aws_autoscaling_policy" "my_dynamic_scaledown_policy" {
  autoscaling_group_name = aws_autoscaling_group.my_asg_test.name
  name                   = "my_dynamic_scaledown_policy"
  adjustment_type        = "ChangeInCapacity"
  policy_type            = "SimpleScaling"
  scaling_adjustment     = -1


  cooldown = var.cooldown_period

}

# Cloudwatch Metric to use for simple scaling
resource "aws_cloudwatch_metric_alarm" "my_dynamic_scaleup_alarm" {
  evaluation_periods = 2
  alarm_name         = "my_dynamic_scaleup_alarm"
  alarm_actions      = [aws_autoscaling_policy.my_dynamic_scaleup_policy.arn]
  metric_name        = "CPUtilization"

  threshold           = 50
  period              = 120
  namespace           = "AWS/EC2"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  statistic           = "Maximum"

  actions_enabled = true

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg_test.name
  }

}

resource "aws_cloudwatch_metric_alarm" "my_dynamic_scaledown_alarm" {
  evaluation_periods = 2
  alarm_name         = "my_dynamic_scaledown_alarm"
  alarm_actions      = [aws_autoscaling_policy.my_dynamic_scaledown_policy.arn]
  metric_name        = "CPUtilization"

  threshold           = 30
  period              = 120
  namespace           = "AWS/EC2"
  comparison_operator = "LessThanOrEqualToThreshold"
  statistic           = "Maximum"

  actions_enabled = true

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_asg_test.name
  }

}