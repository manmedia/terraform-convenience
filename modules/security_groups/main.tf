# Terraform metadata

### Data for security groups ###


### ------------------------ ###

# Define security group resources
# You will be prompted to enter the VPC ID if not provided as part of variables.tf file
#
#
# ------ HTTP TRAFFIC -> AMAZON ELB ALB (80 -> 4567) -> Target Group (EC2 Instances listening to Port 4567)
resource "aws_security_group" "access_port_22" {
  vpc_id = var.vpc_id
  name   = "access_port_22"

  # open_port_22"
  ingress {
    description = "SSH Ingress rule"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_addr_cidr]
  }
  tags = {
    Name      = "ACCESS_PORT_22"
    Terraform = "true"
  }
}

resource "aws_security_group" "access_port_80" {
  vpc_id = var.vpc_id
  name   = "access_port_80"

  # "open_port_80"
  ingress {
    description = "Specific TCP port ingress rule"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.source_cidr_block]
  }
  tags = {
    Name      = "ACCESS_PORT_80"
    Terraform = "true"
  }
}

resource "aws_security_group" "access_port_8080" {
  vpc_id = var.vpc_id
  name   = "access_port_8080"

  # "Accept connection from Security Group for port 8080"
  ingress {
    description     = "Specific TCP port ingress rule"
    from_port       = 8080
    to_port         = 8080
    protocol        = "tcp"
    security_groups = [aws_security_group.access_port_80.id]
  }


  tags = {
    Name      = "ACCESS_PORT_8080"
    Terraform = "true"
  }
}

resource "aws_security_group" "access_port_4567" {
  vpc_id = var.vpc_id
  name   = "access_port_4567"

  # "Accept connection from Security Group for port 4567"
  ingress {
    description     = "Specific TCP port ingress rule"
    from_port       = 4567
    to_port         = 4567
    protocol        = "tcp"
    security_groups = [aws_security_group.load_balancer_ingress_egress.id]
  }

  tags = {
    Name      = "ACCESS_PORT_4567"
    Terraform = "true"
  }
}

# Enable Outbound calls for TCP only
resource "aws_security_group" "enable_outbound_calls_tcp" {
  vpc_id = var.vpc_id
  name   = "enable_outbound_calls_tcp"

  egress {
    description = "TCP egress rule"
    cidr_blocks = [var.source_cidr_block]
    from_port   = 0
    to_port     = 0
    protocol    = "tcp"
  }

  tags = {
    Name      = "enable_outbound_calls_tcp"
    Terraform = "true"
  }
}

## For a different machine, We want to ensure that only port 22 is open for ingress from a given IP CIDR Block
## For the above machine, we only want the egress -> ingress for port 4567 between EC2 machines

resource "aws_security_group" "load_balancer_ingress_egress" {
  vpc_id = var.vpc_id
  name   = "ALB_INGRESS_EGRESS"

  tags = {
    Name      = "ALB_INGRESS_EGRESS"
    Terraform = "true"
  }
}

resource "aws_security_group_rule" "load_balancer_ingress_rule" {
  type              = "ingress"
  description       = "Specific TCP port egress rule"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.load_balancer_ingress_egress.id
}

resource "aws_security_group_rule" "load_balancer_egress_rule" {
  type                     = "egress"
  description              = "Specific TCP port ingress rule"
  from_port                = 4567
  to_port                  = 4567
  protocol                 = "tcp"
  security_group_id        = aws_security_group.load_balancer_ingress_egress.id
  source_security_group_id = aws_security_group.access_port_4567.id
}


