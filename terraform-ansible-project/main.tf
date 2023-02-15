

#########################################################
# CREATING PROVIDER BLOCK
#########################################################

provider "aws" {
  region  = var.region
  profile = var.profile

  default_tags {
    tags = {
      name = "ansible_work"
      env  = "sbx"
    }
  }
}

#########################################################
# CREATING DATA SOURCE BLOCK
#########################################################

data "aws_ami" "ami_amazon" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-*-gp2"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

#########################################################
# CREATING LOCAL BLOCK
#########################################################

locals {
  vpc_id = aws_vpc.sbx_vpc.id
  azs    = data.aws_availability_zones.available.names

}

#########################################################
# CREATING RESOURCE BLOCK
#########################################################

resource "aws_instance" "ansible_worknodes" {
  count           = 3
  ami             = data.aws_ami.ami_amazon.id
  instance_type   = var.instance_type
  subnet_id       = aws_subnet.public_subnet.id
  key_name        = var.key_name
  security_groups = [aws_security_group.ansible_sg.id]


  tags = {
    Name = "${var.env}-ansible-work-node ${count.index + 1}"
  }
}

resource "aws_vpc" "sbx_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "${var.env}-vpc"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = local.vpc_id
  cidr_block              = var.public_subnet_cidr
  availability_zone       = local.azs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.env}-public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = local.vpc_id

  tags = {
    Name = "${var.env}-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = local.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "${var.env}-route-table"
  }
}

resource "aws_main_route_table_association" "a" {
  vpc_id         = local.vpc_id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "ansible_sg" {
  name        = "allow_ssh"
  description = "Allow ssh inbound traffic"
  vpc_id      = local.vpc_id


  tags = {
    Name = "${var.env}-ansible-sg"
  }
}

resource "aws_security_group_rule" "ingress" {
  count             = length(var.ports)
  type              = "ingress"
  from_port         = var.ports[count.index]
  to_port           = var.ports[count.index]
  protocol          = var.protocol[count.index]
  cidr_blocks       = ["75.189.149.30/32"]
  security_group_id = aws_security_group.ansible_sg.id
}

resource "aws_security_group_rule" "egress" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ansible_sg.id
}

