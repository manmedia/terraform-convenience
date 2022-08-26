# Number of availability Zones
data "aws_availability_zones" "total_az" {
  filter {
    name   = "region-name"
    values = [var.aws_target_region]
  }
}

# Total number of subnets
data "aws_subnet_ids" "total_subnets" {
  vpc_id = var.vpc_id
}

# Available  via "local." references
# Use count in module/resources where appropriate
# Be mindful of "list" / "set" iteration issues when referencing them for indices

locals {
  availability_zones     = data.aws_availability_zones.total_az.names
  subnets                = tolist(data.aws_subnet_ids.total_subnets.ids)
  available_subnet_count = length(local.subnets)
}

module "security_groups" {
  source            = "./modules/security_groups"
  vpc_id            = var.vpc_id
  my_ip_addr_cidr   = var.my_ip_addr_cidr
  aws_target_region = var.aws_target_region
  source_cidr_block = var.source_cidr_block
}

# Create 1 EC2 instance in each AZ
# Using interpolation syntax and meta argument
# Using meta argument to spread instances across AZs


module "aws_ec2_machines" {
  source                  = "./modules/ec2_machines"
  count                   = length(local.availability_zones)
  launch_template_id      = var.launch_template_id
  launch_template_version = var.launch_template_version
  ec2_instance_name       = "${var.ec2_instance_name}-${count.index + 1}"
  subnet_id               = local.subnets[count.index % local.available_subnet_count]
}

# Now create load balancer

module "aws_application_load_balancer" {
  source                  = "./modules/load_balancers"
  list_of_target_ids      = toset(module.aws_ec2_machines[*].instance_id)
  subnets_for_elb         = local.subnets
  target_group_name       = var.target_group_name
  target_group_vpc_id     = var.vpc_id
  security_groups_for_elb = [module.security_groups.load_balancer_sg_id]
  load_balancer_name      = var.load_balancer_name


  vpc_id = var.vpc_id

  elb_listener_port        = var.elb_listener_port
  elb_check_interval       = var.elb_check_interval
  elb_forward_port         = var.elb_forward_port
  elb_health_check_path    = "/health"
  elb_health_check_port    = var.elb_forward_port
  elb_unhealthy_threshold  = var.elb_unhealthy_threshold
  elb_healthy_threshold    = var.elb_healthy_threshold
  elb_health_check_timeout = var.elb_health_check_timeout
}

# And finally, Auto Scaling Group
module "aws_auto_scaling_group" {
  source = "./modules/auto_scaling"

  autoscaling_min_instances    = 3
  autoscaling_desired_capacity = 3
  autoscaling_max_instances    = 4

  target_group_arns = [module.aws_application_load_balancer.target_group_arn_value]



  launch_template_id      = var.launch_template_id
  launch_template_version = var.launch_template_version

  public_subnet_list = local.subnets

}
