resource "aws_db_instance" "db" {
  allocated_storage      = 10
  storage_type           = "gp2"
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t2.micro"
  name                   = "wordpress"
  username               = var.rds_user
  password               = var.rds_pass
  parameter_group_name   = "default.mysql5.7"
  vpc_security_group_ids = [var.app_sg]
}
