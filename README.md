# Terraform with Ansible provisioning

## Prerequisites

* terraform >=0.12
* ansible >=1.4
* Before applying, `terraform.tfvars` needs the values filled

## This scenarios will create following resources:

* AWS VPC
* Security groups and subnets for the VPC
* EC2 instance to run the web server
* MySQL 5.7 RDS instance
* A HTTP Application LoadBalancer

## Usage:

```bash run.sh```