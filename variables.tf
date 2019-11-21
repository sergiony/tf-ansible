
variable "aws_region" {
  type        = string
  description = "Used AWS Region."
}

variable "aws_access_key" {
  type        = string
  description = "The account identification key used by your Terraform client."
}

variable "aws_secret_key" {
  type        = string
  description = "The secret key used by your terraform client to access AWS."
}

variable "subnet_count" {
  type        = string
  description = "The number of subnets we want to create per type to ensure high availability."
}

variable "accessing_computer_ip" {
  type        = string
  description = "IP of the computer to be allowed to connect to instances."
}

variable "instance_type" {
  type = string
  description = "Instance type"
}

variable "ami_id" {
  type = string
  description = "AMI ID for instances"
}

variable "public_key" {
  type = string
  description = "SSH public key used to connect to instances"
}

variable "rds_user" {
  type = string
  description = "RDS user"
}

variable "rds_pass" {
  type = string
  description = "SSH public key used to connect to instances"
}
