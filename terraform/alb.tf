/* alb */
resource "aws_lb" "kb-alb" {
  name                       = "kb-alb"
  load_balancer_type         = "application"
  internal                   = false
  idle_timeout               = 60
  enable_deletion_protection = false

  subnets = [
    aws_subnet.kb-front-1a.id,
    aws_subnet.kb-front-1c.id
  ]

  security_groups = [
    aws_security_group.kb-alb-sg.id
  ]

  tags = {
    Name = "kb-alb"
  }
}

/* listener */
resource "aws_lb_listener" "kb-http-listener" {
  load_balancer_arn = aws_lb.kb-alb.arn
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
resource "aws_lb_listener" "kb-https-listener" {
  load_balancer_arn = aws_lb.kb-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.kb-acm.arn

  default_action {
    target_group_arn = aws_lb_target_group.kb-alb-front-tg.arn
    type             = "forward"
  }
}
resource "aws_lb_listener" "kb-back-listener" {
  load_balancer_arn = aws_lb.kb-alb.arn
  port              = "3000"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.kb-acm.arn

  default_action {
    target_group_arn = aws_lb_target_group.kb-alb-back-tg.arn
    type             = "forward"
  }
}

/* target-group */
resource "aws_lb_target_group" "kb-alb-front-tg" {
  name        = "kb-alb-front-tg"
  target_type = "ip"
  vpc_id      = aws_vpc.kb-vpc.id
  port        = 80
  protocol    = "HTTP"

  health_check {
    enabled             = true
    path                = "/"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 120
    interval            = 150
    matcher             = 200
    port                = 80
    protocol            = "HTTP"
  }
}
resource "aws_lb_target_group" "kb-alb-back-tg" {
  name        = "kb-alb-back-tg"
  target_type = "ip"
  vpc_id      = aws_vpc.kb-vpc.id
  port        = 3000
  protocol    = "HTTP"

  health_check {
    enabled             = true
    interval            = 60
    path                = "/api/v1/health_check"
    port                = 3000
    protocol            = "HTTP"
    matcher             = 200
    timeout             = 50
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }
}
