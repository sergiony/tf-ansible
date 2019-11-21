resource "aws_security_group" "alb-sg" {
  name        = "alb-public"
  description = "Security group allowing public traffic for the load balancer."
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = map(
     "Name", "webapp-alb"
    )
}

resource "aws_security_group_rule" "alb-public-http" {
  description       = "Allow load balancer to communicate with public traffic."
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.alb-sg.id
  to_port           = 80
  type              = "ingress"
}
