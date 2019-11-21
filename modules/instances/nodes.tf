########################################################################################
# Setup instances and target groups

resource "aws_key_pair" "webapp" {
  key_name   = "deployer-key"
  public_key = var.public_key
}


resource "aws_instance" "web" {
  ami = var.ami_id
  instance_type = var.instance_type
  vpc_security_group_ids = [var.app_sg]
  associate_public_ip_address = true
  user_data = local.node-userdata
  key_name = aws_key_pair.webapp.key_name
  tags = {
    Name = "WebApp"
  }
}

locals {
  node-userdata = <<USERDATA
#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
apt update -qq && apt install apache2 ansible php7.2-mysql libapache2-mod-php7.2 php7.2-gd php7.2-ssh2 -yqq
sed -i 's=/var/www/html=/var/www/wordpress=' /etc/apache2/sites-enabled/000-default.conf

USERDATA
}


resource "aws_lb_target_group" "webapp" {
  name = "webapp-tg"
  port = 80
  protocol = "HTTP"
  vpc_id = var.vpc_id
  target_type = "instance"
  health_check {
    path = "/index.php"
    matcher = "200,302"
    protocol = "HTTP"
  }
}

resource "aws_lb_target_group_attachment" "web" {
  target_group_arn = aws_lb_target_group.webapp.arn
  target_id        = aws_instance.web.id
  port             = 80
}

