variable "vpc_id" {
  sensitive   = "true"
  description = "ID of the VPC within which you may be operating"
}

variable "my_ip_addr_cidr" {
  sensitive   = "true"
  description = "My IP address value"
}

variable "source_cidr_block" {
  sensitive   = "true"
  description = "Source address CIDR block"
}