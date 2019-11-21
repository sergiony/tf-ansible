resource "aws_alb" "webapp-alb" {
  name            = "webapp-alb"
  subnets         = flatten([var.app_subnet_ids])
  security_groups = [var.app_sg, aws_security_group.alb-sg.id]
  ip_address_type = "ipv4"
  
  tags = map(
     "Name", "webapp"
    )
}

resource "aws_alb_listener" "webapp-listener" {
  load_balancer_arn = aws_alb.webapp-alb.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type              = "forward"
    target_group_arn = var.target_group_arn
  }
}


resource "aws_alb_listener_rule" "back_end_api" {
  listener_arn = aws_alb_listener.webapp-listener.arn
  priority     = 90

  action {
    type             = "forward"
    target_group_arn = "${var.convertr_tg_arn}"
  }

  condition {
    field  = "path-pattern"
    values = ["/*"]
  }
}

