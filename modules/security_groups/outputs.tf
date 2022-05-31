output "load_balancer_sg_id" {
  description = "value of the security group needed for load balancer"
  value       = aws_security_group.load_balancer_ingress_egress.id
}

output "outbound_only_tcp_sg" {
  description = "Egress to internet only"
  value       = aws_security_group.enable_outbound_calls_tcp.id
}

output "ingress_tcp_port_4567" {
  description = "Only port 4567 ingress TCP"
  value       = aws_security_group.access_port_4567.id
}

output "ingress_ssh_only" {
  description = "Only port 22 ingress TCP"
  value       = aws_security_group.access_port_22.id
}

output "ingress_tcp_80" {
  description = "Only port 80 ingress TCP"
  value       = aws_security_group.access_port_80.id
}

output "ingress_tcp_8080" {
  description = "Only port 8080 ingress TCP"
  value       = aws_security_group.access_port_8080.id
}