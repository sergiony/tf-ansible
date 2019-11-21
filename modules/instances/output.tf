output "rds_endpoint" {
   value = aws_db_instance.db.address
}

output "node_ip" {
   value = aws_instance.web.public_ip
}

output "target_group" {
   value = aws_lb_target_group.webapp.arn
}

