#!/bin/bash
set -e

# Run Terraform Provisioning
terraform init
terraform apply -auto-approve

# Apply ansible playbook

cd ansible
ansible-playbook -i inventory playbook.yml

echo "Provisioning completed"

cd ..
terraform output
