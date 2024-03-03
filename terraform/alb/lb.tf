# Terraform AWS Application Load Balancer (ALB)
resource "aws_lb" "alb" {
  name               = "alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  subnets            = [for subnet_data in data.aws_subnet.public : subnet_data.id]

}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = "arn:aws:acm:us-east-1:891377060995:certificate/74470b1c-0928-4080-8e80-7959c997dde1"
  ssl_policy        = "ELBSecurityPolicy-2016-08" 

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.lb_target.arn
  }
}

resource "aws_acm_certificate" "certificate" {
  
  domain_name       = "timeoff.management.com"
  validation_method = "DNS"

  tags = {
    Environment = "test"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb_listener_certificate" "lb_certificate" {
  listener_arn = aws_lb_listener.front_end.arn
  certificate_arn = aws_acm_certificate.certificate.arn
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_lb_target_group" "lb_target" {
  name        = "lb-target"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = data.aws_vpc.main.id

  health_check {
    enabled             = true
    interval            = 30
    path                = "/app1/index.html"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 6
    protocol            = "HTTP"
    matcher             = "200-399"
  }
}

resource "aws_security_group" "lb_sg" {
  vpc_id =  data.aws_vpc.main.id

  ingress {
    description = "Self from VPC"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }

  egress {
    description = "all egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  
}