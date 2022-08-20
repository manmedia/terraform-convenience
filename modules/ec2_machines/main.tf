
# Module description to create EC2s using launch templates
# By default - Termination is enabled
# By default - "Shutdown" means "Stop" instances
# By default - "Delete block device upon termination"

resource "aws_instance" "my-sample-webapp-ec2" {
  subnet_id                            = var.subnet_id
  instance_initiated_shutdown_behavior = "stop"
  disable_api_termination              = false

  launch_template {
    id      = var.launch_template_id
    version = "$Latest"
  }

  tags = {
    "Name" = var.ec2_instance_name
  }

  root_block_device {
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [user_data, tags]
  }

}
