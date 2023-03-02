

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
# CREATING EC2 FOR JENKINS
#########################################################

resource "aws_instance" "app1" {
  ami                    = data.aws_ami.ami_amazon.id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnet_id[0]
  iam_instance_profile   = aws_iam_instance_profile.instance_profile.name
  user_data              = file("${path.module}/templates/jenkins.sh")
  vpc_security_group_ids = [aws_security_group.allow_jenkins.id]

  tags = {
    Name = "${var.component}-jenkins-server"
  }
}
