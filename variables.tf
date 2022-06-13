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

variable "aws_target_region" {
  description = "target region for which the automation would run"
  type        = string
}

# EC2 specific
variable "ec2_instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "launch_template_id" {
  description = "launch template id"
  default     = ""
}

variable "launch_template_ver" {
  description = "version of the launch template"
  default     = 1
}

variable "health_check_path" {
  description = "version of the launch template"
  default     = "/health"
}