variable "vpc_id" {
 type = string
 description = "VPC ID"
}
variable "subnet_count" {
    type        = string
    description = "The number of subnets"
}

variable "subnets" {
    type        = any
    description = "Subnet ids"
}

variable "lb_sg" {
    type        = string
    description = "LB security group ID"
}

variable "app_sg" {
    type        = string
    description = "Web app security group ID"
}

variable "ami_id" {
    type        = string
    description = "AMI ID to spin up the instance"
}

variable "public_key" {
    type        = string
    description = "SSH Public key for instance"
}

variable "instance_type" {
    type        = string
    description = "SSH Public key for instance"
}

variable "rds_user" {
    type        = string
    description = "RDS User"
}

variable "rds_pass" {
    type        = string
    description = "RDS Pass"
}
