cd ../kubespray

ansible-playbook -i inventory/kubecluster/hosts.yml --become --become-user=root reset.yml

# remove  config and kubecluster
rm -rf ~/.kube

rm -rf inventory/kubecluster

    
