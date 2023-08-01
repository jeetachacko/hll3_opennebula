
## Configuring the scripts
You need to adjust the settings in the `terraform` and `ansible` folder. 

### Terraform
You may want to specify what type of VMs you would like to have. Go to `terraform/virtual-machines.tf` and adjust the 
parameters as needed. 
A guide is available in our [Wiki](https://wiki.tum.de/pages/viewpage.action?pageId=1310363151).

You must set your OpenNebula credentials and the VM configuration in `terraform/config.tfvars`. 
**NEVER COMMIT THIS FILE ONCE YOU HAVE ADDED YOU CREDENTIALS!**

### Ansible
You may configure the ansible deployment automation as you like. Make sure to add all new roles (deployment instructions)
to `ansible/automate-deployment.yaml`.
