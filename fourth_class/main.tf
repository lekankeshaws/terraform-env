

###########################################################
# RESOURCE BLOCK
############################################################
resource "aws_instance" "test_server" {
  for_each = local.ec2_instance # calling the local reference

  ami             = each.value.ami # calling the list of ami variable
  instance_type   = "t2.micro"
  subnet_id       = each.value.subnet
  security_groups = each.value.security_groups
  key_name        = each.value.key_1

  tags = {
    Name = each.key
  }
}

resource "aws_vpc" "dev_vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "dev_vpc"
  }

}

resource "aws_subnet" "public_subnet" {
  for_each = local.public_subnet

  vpc_id                  = local.vpc_id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.azs_to_use
  map_public_ip_on_launch = true

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "private_app_subnet" {
  for_each          = local.private_app_subnet
  vpc_id            = local.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.azs_to_use

  tags = {
    Name = each.key
  }
}

resource "aws_subnet" "database_subnet" {
  for_each          = local.database_subnet
  vpc_id            = local.vpc_id
  cidr_block        = each.value.cidr
  availability_zone = each.value.azs_to_use

  tags = {
    Name = each.key
  }
}

resource "aws_security_group" "server_sg" {

  name        = "server security group"
  description = "allow ssh & ping inbound traffic"
  vpc_id      = local.vpc_id

  ingress {
    description = "ssh from vpc"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.cidr_block_ssh]
  }

  ingress {
    description = "ping from pc"
    from_port   = "-1"
    to_port     = "-1"
    protocol    = "icmp"
    cidr_blocks = [var.cidr_block_ssh]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "server_sg"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = local.vpc_id

  route {
    cidr_block = var.public_subnet_cidr
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "igw"
  }
}

resource "aws_main_route_table_association" "rt_table_ass" {
  vpc_id         = local.vpc_id
  route_table_id = aws_route_table.public_route_table.id
}

