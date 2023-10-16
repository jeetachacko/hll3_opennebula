#!/usr/bin/env bash

source `dirname $0`/env_setup.sh
start=`date +%s`

set -x

#Ensure your local ssh-agent is running and your ssh key has been added.
#This step is required by the terraform provisioner.
eval $(ssh-agent -s)
ssh-add ~/.ssh/id_rsa


cd kubespray/
# change working directory and install Python

sudo pip3 install -r requirements.txt
# install Python dependencies
sudo pip3 install -r contrib/inventory_builder/requirements.txt
# copy sample of inventory to kubecluster
cp -rfp inventory/sample inventory/kubecluster

# create variable IPS
declare -a IPS=(172.24.33.153 172.24.33.154 172.24.33.155) #Add IPS seperated by space

# generating inventory file
CONFIG_FILE=inventory/kubecluster/hosts.yml python3 contrib/inventory_builder/inventory.py ${IPS[@]}

# deploy Kubernetes Cluster
ansible-playbook -i inventory/kubecluster/hosts.yml --become --become-user=root cluster.yml




# OLD = fill hosts.ini with the actual values and configure kubectl
#ansible-playbook -i hosts ./kubectl-config/playbook.yaml

# Install agro controller with the configured kubectl
#kubectl create namespace argo
#kubectl apply -n argo -f ../fabric/argo/install.yaml
#kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=default:default

set +x

end=`date +%s`
runtime=$((end-start))
echo "Runtime: $runtime seconds."

