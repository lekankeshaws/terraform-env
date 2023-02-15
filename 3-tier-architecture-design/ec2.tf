
#########################################################
# DATA SOURCE
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

#########################################################
# CREATING EC2 INSTANCE SERVER 1
#########################################################

resource "aws_instance" "app1" {
  ami                    = data.aws_ami.ami_amazon.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.backend_subnet[0].id
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  user_data              = "${path.module}/templates/app1.sh"
  vpc_security_group_ids = [aws_security_group.security["app1_sg"].id]

  tags = {
    Name = "${terraform.workspace}-app1"
  }
}

#########################################################
# CREATING EC2 INSTANCE FOR SERVER 2
#########################################################

resource "aws_instance" "app2" {
  ami                    = data.aws_ami.ami_amazon.id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.backend_subnet[1].id
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  user_data              = "${path.module}/templates/app2.sh"
  vpc_security_group_ids = [aws_security_group.security["app2_sg"].id]

  tags = {
    Name = "${terraform.workspace}-app2"
  }
}

#########################################################
# CREATING EC2 INSTANCE REGISTRATION APP
#########################################################

resource "aws_instance" "registration_app" {
  depends_on = [aws_db_instance.registration_app_db]

  ami                    = data.aws_ami.ami_amazon.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.security["registration_sg"].id]
  subnet_id              = aws_subnet.backend_subnet[0].id
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  user_data = templatefile("${path.root}/templates/registration_app.tmpl",
    {
      hostname    = aws_db_instance.registration_app_db.address
      db_name     = var.db_name
      db_username = var.username
      db_password = random_password.password.result
      db_port     = var.port
  })

  tags = {
    Name = "${terraform.workspace}-registration_app"
  }
}