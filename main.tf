# Terraform metadata

### Data for security groups ###


### ------------------------ ###

# Define security group resources
# You will be prompted to enter the VPC ID if not provided as part of variables.tf file
#
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
    cidr_blocks = [var.my_ip_addr_cidr]
  }
  tags = {
    Name      = "ACCESS_PORT_80"
    Terraform = "true"
  }
}

resource "aws_security_group" "access_port_8080" {
  vpc_id = var.vpc_id
  name   = "access_port_8080"

  # "open_port_8080"
  ingress {
    description = "Specific TCP port ingress rule"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_addr_cidr]
  }


  tags = {
    Name      = "ACCESS_PORT_8080"
    Terraform = "true"
  }
}

resource "aws_security_group" "access_port_4567" {
  vpc_id = var.vpc_id
  name   = "access_port_4567"

  # "open_port_4567"
  ingress {
    description = "Specific TCP port ingress rule"
    from_port   = 4567
    to_port     = 4567
    protocol    = "tcp"
    cidr_blocks = [var.my_ip_addr_cidr]
  }

  tags = {
    Name      = "ACCESS_PORT_4567"
    Terraform = "true"
  }
}



