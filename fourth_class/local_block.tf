

#########################################################
# LOCAL BLOCK
#########################################################
locals {
  azs = data.aws_availability_zones.available.names

  ec2_instance = {
    server_1 = {
      ami             = data.aws_ami.ami_amazon.id
      subnet          = aws_subnet.public_subnet["public_subnet_1"].id
      security_groups = [aws_security_group.server_sg.id]
      key_1           = "mynewkey"
    }
    server_2 = {
      ami             = data.aws_ami.ami_ubuntu.id
      subnet          = aws_subnet.public_subnet["public_subnet_2"].id
      security_groups = [aws_security_group.server_sg.id]
      key_1           = "mynewkey"
    }
  }

  public_subnet = {
    public_subnet_1 = {
      cidr       = "10.0.1.0/24"
      azs_to_use = local.azs[0]
    }
    public_subnet_2 = {
      cidr       = "10.0.3.0/24"
      azs_to_use = local.azs[1]
    }
  }

  private_app_subnet = {
    private_app_subnet_1 = {
      cidr       = "10.0.0.0/24"
      azs_to_use = data.aws_availability_zones.available.names[0]
    }
    private_app_subnet_2 = {
      cidr       = "10.0.2.0/24"
      azs_to_use = data.aws_availability_zones.available.names[1]
    }
  }

  database_subnet = {
    database_subnet_1 = {
      cidr       = "10.0.51.0/24"
      azs_to_use = data.aws_availability_zones.available.names[0]
    }
    database_subnet_2 = {
      cidr       = "10.0.53.0/24"
      azs_to_use = data.aws_availability_zones.available.names[1]
    }
  }
}