variable "instance_ip" {
  type = "string"
  description = "IP of the server."
}
variable "rds_address" {
  type = any
  description = "MySQL RDS Endpoint."
}

variable "rds_user" {
  type = "string"
  description = "ID of the Security Group used by the nodes."
}

variable "rds_pass" {
  type = "string"
  description = "ARN of the Target Group pointing at the web app."
}
