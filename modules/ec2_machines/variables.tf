variable "subnet_id" {
  description = "Which subnet does this EC2 instance belong to"
  type        = string
  default     = ""
}

variable "launch_template_id" {
  description = "Uses a launch_template_id"
  default     = ""
}

variable "launch_template_ver" {
  description = "Which version does it belong to"
  type        = number
  default     = 1
}

variable "ec2_instance_name" {
  description = "Name of the instance"
  type        = string
}

variable "availability_zone" {
  description = "Which AWS AZ it falls into?"
  type        = string
  default     = ""
}