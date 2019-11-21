variable "vpc_id" {
  type = string
}
variable "app_subnet_ids" {
  type = any
  description = "List containing the IDs of load balancer subnets."
}

variable "app_sg" {
  type = string
  description = "ID of the Security Group used by the nodes."
}

variable "target_group_arn" {
  type = string
  description = "ARN of the Target Group pointing at the web app."
}
