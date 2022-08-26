variable "launch_template_version" {
  default = ""
}

variable "launch_template_id" {
  default = ""
}

variable "autoscaling_min_instances" {
  default = ""
}


variable "autoscaling_desired_capacity" {
  default = ""
}


variable "autoscaling_max_instances" {
  default = ""
}

variable "public_subnet_list" {
  type    = list(string)
  default = []
}

variable "target_group_arns" {
  type    = list(string)
  default = []
}

variable "cooldown_period" {
  type    = number
  default = 60
}