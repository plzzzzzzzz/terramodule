resource "aws_lb" "jskim_alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.jskim_sg.id]
  subnets            = [aws_subnet.jskim_pub[0].id, aws_subnet.jskim_pub[1].id]

  tags = {
    "Name" = "${var.name}-alb"
  }
}


resource "aws_lb_target_group" "jskim_albtg" {
  name     = "${var.name}-albtg"
  port     = var.port_http
  protocol = "HTTP"
  vpc_id   = aws_vpc.jskim_vpc.id

  health_check {
    enabled             = true
    healthy_threshold   = 3
    interval            = 5
    matcher             = "200"
    path                = "/health.html"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 2
    unhealthy_threshold = 2
  }
}


resource "aws_lb_listener" "jskim_albli" {
  load_balancer_arn = aws_lb.jskim_alb.arn
  port              = var.port_http
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.jskim_albtg.arn
  }
}


resource "aws_lb_target_group_attachment" "jskim_tgatt" {
  target_group_arn = aws_lb_target_group.jskim_albtg.arn
  target_id        = aws_instance.jskim_weba.id
  port             = var.port_http
}
