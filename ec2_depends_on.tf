resource "aws_instance" "web" {

  ami           = "ami-0c02fb55956c7d316" # Update for your region
  instance_type = local.env.instance_type

  subnet_id              = aws_subnet.public.id
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  associate_public_ip_address = true

  depends_on = [
    aws_vpc.main,
    aws_subnet.public,
    aws_internet_gateway.igw,
    aws_route_table.public,
    aws_route_table_association.public,
    aws_security_group.allow_tls
  ]

  tags = {
    Name = "web-server${local.env_suffix}"
    Env  = terraform.workspace
  }
}