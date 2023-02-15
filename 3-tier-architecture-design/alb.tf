

#########################################################
# CREATING ALB
#########################################################

module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 6.0"

  name = "${var.component}-web-alb"

  load_balancer_type = "application"

  vpc_id             = local.vpc_id
  subnets            = aws_subnet.public_subnet[*].id
  security_groups    = [aws_security_group.security["alb_sg"].id]

  target_groups = [
    {
      name_prefix      = "app1-"
      backend_protocol = "HTTP"
      backend_port     = 80
      target_type      = "instance"
      deregistration_delay = 10
      targets = {
        my_target = {
          target_id = "i-0123456789abcdefg"
          port = 80
        }
        my_other_target = {
          target_id = "i-a1b2c3d4e5f6g7h8i"
          port = 8080
        }
      }
    }
  ]

  https_listeners = [
    {
      port               = 443
      protocol           = "HTTPS"
      certificate_arn    = "arn:aws:iam::123456789012:server-certificate/test_cert-123456789012"
      target_group_index = 0
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "HTTP"
      action_type = "redirect"
      redirect = {
        port = "443"
        protocol = "HTTPS"
        status_code = "HTTP_301"
      }
    }
  ]

  tags = {
    Environment = "Test"
  }
}

resource "aws_route53_zone" "this" {
  name = var.dns_name
}