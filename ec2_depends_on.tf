
# KEY PAIR
resource "aws_key_pair" "deployer" {
  key_name   = var.key_name
  public_key = file(var.public_key_path)
}

# DEFAULT VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = var.vpc_name
  }
}

# SECURITY GROUP
resource "aws_security_group" "allow_tls" {
  name        = var.sg_name
  description = var.sg_description
  vpc_id      = aws_default_vpc.default.id

  tags = {
    Name = var.sg_name
  }
}

# INGRESS RULE - SSH
resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  from_port         = var.ssh_port
  to_port           = var.ssh_port
  ip_protocol       = "tcp"
  cidr_ipv4         = var.allowed_cidr
  description       = "SSH Open"
}

# Ingress Rule - Allow HTTP (Port 80)
resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.allow_tls.id
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTP traffic"
}

# Ingress Rule - Allow HTTPS (Port 443)
resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.allow_tls.id
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow HTTPS traffic"
}

# EGRESS RULE
resource "aws_vpc_security_group_egress_rule" "allow_all" {
  security_group_id = aws_security_group.allow_tls.id
  ip_protocol       = "-1"
  cidr_ipv4         = "0.0.0.0/0"
  description       = "Allow all outbound traffic"
}

# EC2 INSTANCE
resource "aws_instance" "web" {
  for_each = var.instances # creates 2 EC2 machines, one per map entry

  ami                    = var.ami_id
  instance_type          = each.value

  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]
  user_data              = file("${path.module}/install_nginx.sh")

  # Explicit dependency: make sure the key pair and all security group rules
  # exist before any EC2 instance is created
  depends_on = [
    aws_key_pair.deployer,
    aws_vpc_security_group_ingress_rule.allow_tls_ipv4,
    aws_vpc_security_group_ingress_rule.allow_http,
    aws_vpc_security_group_ingress_rule.allow_https,
    aws_vpc_security_group_egress_rule.allow_all
  ]

  root_block_device {
    encrypted   = var.volume_encrypted
    volume_type = var.volume_type
    throughput  = var.volume_throughput
    volume_size = var.volume_size

    tags = {
      Name = var.root_volume_name
    }
  }

  tags = {
    Name = each.key
  }
}