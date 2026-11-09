resource "aws_vpc" "main" {

  cidr_block           = local.env.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "demo-vpc${local.env_suffix}"
    Env  = terraform.workspace
  }
}

resource "aws_subnet" "public" {

  vpc_id                  = aws_vpc.main.id
  cidr_block              = local.env.subnet_cidr
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet${local.env_suffix}"
  }
}

resource "aws_internet_gateway" "igw" {

  vpc_id = aws_vpc.main.id

  tags = {
    Name = "igw${local.env_suffix}"
  }
}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-rt${local.env_suffix}"
  }
}

resource "aws_route_table_association" "public" {

  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}