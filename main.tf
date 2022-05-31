module "security_groups" {
  source            = "./modules/security_groups"
  vpc_id            = var.vpc_id
  my_ip_addr_cidr   = var.my_ip_addr_cidr
  aws_target_region = var.aws_target_region
  source_cidr_block = var.source_cidr_block
}