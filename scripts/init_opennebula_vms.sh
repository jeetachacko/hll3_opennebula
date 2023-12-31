#!/usr/bin/env bash

source `dirname $0`/env_setup.sh
start=`date +%s`

set -x

# Setup Openstack instances for k8s nodes using Terraform
#cd terraform/
#terraform init  #Install the required plugins
#Provisioning cluster
#terraform apply -var-file=./cluster.tfvars -auto-approve

#Ensure your local ssh-agent is running and your ssh key has been added. 
#This step is required by the terraform provisioner.
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa 


#create OpenNebula instances for k8s nodes using Terraform

cd openNebula/terraform-vm/
bash automate-deployment.sh 

# Setup k8s cluster
#ansible-playbook --become -i hosts ../kubespray/cluster.yml

# fill hosts.ini with the actual values and configure kubectl
#ansible-playbook -i hosts ./kubectl-config/playbook.yaml

# Install agro controller with the configured kubectl
#kubectl create namespace argo
#kubectl apply -n argo -f ../fabric/argo/install.yaml
#kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=default:default

set +x

end=`date +%s`
runtime=$((end-start))
echo "Runtime: $runtime seconds."
