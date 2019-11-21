variable "aws_region" {
 type = "string"
 description = "Used AWS Region."
}

variable "subnet_count" {
    type        = "string"
    description = "The number of subnets we want to create per type to ensure high availability."
}

variable "accessing_computer_ip" {
    type        = "string"
    description = "IP to manage the application from"
}
