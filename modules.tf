module "network" {
  source = "./modules/network"

  aws_region            = var.aws_region
  subnet_count          = var.subnet_count
  accessing_computer_ip = var.accessing_computer_ip
}

module "instances" {
  source = "./modules/instances"

  subnet_count      = var.subnet_count
  ami_id            = var.ami_id
  public_key        = var.public_key
  rds_user          = var.rds_user
  rds_pass          = var.rds_pass
  instance_type     = var.instance_type
  vpc_id            = module.network.vpc_id
  subnets           = module.network.app_subnet_ids
  lb_sg             = module.network.lb_security_group
  app_sg            = module.network.app_security_group
}

module "alb" {
  source = "./modules/alb"

  vpc_id                  = module.network.vpc_id
  app_subnet_ids          = module.network.app_subnet_ids
  app_sg                  = module.network.app_security_group
  target_group_arn        = module.instances.target_group
}

module "inventory" {
  source = "./modules/inventory"

  instance_ip = module.instances.node_ip
  rds_address = module.instances.rds_endpoint
  rds_pass = var.rds_pass
  rds_user = var.rds_user
}
