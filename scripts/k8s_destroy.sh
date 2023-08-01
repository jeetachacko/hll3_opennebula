#!/usr/bin/env bash

set -x
# Setup Openstack instances for k8s nodes using Terraform
cd `dirname $0`/../openNebula/terraform-vm/terraform
terraform destroy -var-file=config.tfvars 

set +x
