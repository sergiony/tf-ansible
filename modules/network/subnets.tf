
data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block       = "10.100.0.0/16"
  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "application" {
  count = var.subnet_count
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = "10.100.${count.index}.0/24"
  vpc_id            = aws_vpc.main.id
  tags = map(
     "Name", "web_app"
    )
}

resource "aws_security_group" "web-sg" {
   name        = "main security group"
   description = "Main security group for all web app components in the vpc"
   vpc_id      = aws_vpc.main.id

   egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = [aws_vpc.main.cidr_block]
   }

   tags = {
        Name = "main-sg"
   }
}

resource "aws_security_group" "lb-sg" {
   name        = "load balancer security group"
   description = "Security group for all nodes in the cluster"
   vpc_id      = aws_vpc.main.id

   egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.00"]
   }

   tags = {
        Name = "main-sg"
   }
}

resource "aws_security_group_rule" "office-access" {
  description              = "Allow access from the main office IP"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.web-sg.id
  cidr_blocks              = ["${var.accessing_computer_ip}/32"]
  to_port                  = 65535
  type                     = "ingress"
}
resource "aws_security_group_rule" "ingress-lb" {
  description              = "Allow access from the anywhere to load balancer"
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  security_group_id        = aws_security_group.lb-sg.id
  cidr_blocks              = ["0.0.0.0/0"]
  type                     = "ingress"
}
resource "aws_security_group_rule" "webapp-lb" {
  from_port                = 0
  protocol                 = "tcp"
  security_group_id        = aws_security_group.web-sg.id
  source_security_group_id = aws_security_group.lb-sg.id
  to_port                  = 65535
  type                     = "ingress"
}

