variable "subnets_for_elb" {
  description = "List of subnets for this load balancer"
  type        = list(string)
}

variable "security_groups_for_elb" {
  description = "List of security groups for this load balancer"
  type        = list(string)
}

variable "load_balancer_name" {
  description = "Name of the load balancer"
  type        = string
}

variable "target_group_vpc_id" {
  type = string
}

variable "target_group_name" {
  type = string
}

variable "elb_healthy_threshold" {
  type = number

}

variable "elb_unhealthy_threshold" {
  type = number
}

variable "elb_check_interval" {
  type = number
}

variable "elb_listener_port" {
  type = number
}

variable "elb_health_check_timeout" {
  type = number
}

variable "elb_health_check_path" {
  type = string
}

variable "elb_health_check_port" {
  type = number
}

variable "elb_forward_port" {
  type = number
}

variable "list_of_target_ids" {
  type = set(string)
}

variable "vpc_id" {
  type = string
}
