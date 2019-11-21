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

