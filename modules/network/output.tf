output "app_subnet_ids" {
   value = aws_subnet.application.*.id
}

output "vpc_id" {
   value = aws_vpc.main.id
}
output "lb_security_group" {
   value = aws_security_group.lb-sg.id
}

output "app_security_group" {
   value = aws_security_group.web-sg.id
}
