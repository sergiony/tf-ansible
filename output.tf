output "loadBalancerURL" {
  value = module.alb.aws_alb_address
}

output "instance_ip" {
  value = module.instances.node_ip
}

output "rds_address" {
  value = module.instances.rds_endpoint
}
