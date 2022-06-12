# Number of availability Zones
data "aws_availability_zones" "total_az" {
  filter {
    name   = "region-name"
    values = [var.aws_target_region]
  }
}

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
  source              = "./modules/ec2_machines"
  count               = length(local.availability_zones)
  launch_template_id  = var.launch_template_id
  launch_template_ver = var.launch_template_ver
  ec2_instance_name   = "${var.ec2_instance_name}-${count.index + 1}"
  subnet_id           = local.subnets[count.index % local.available_subnet_count]
}
