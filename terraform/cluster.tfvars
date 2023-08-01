# your Kubernetes cluster name here
cluster_name = "hll"

# availability zone in the OpenStack cluster
availability_zone = "nova"

# SSH key to use for access to nodes
public_key_path = "~/.ssh/id_rsa.pub"

# image to use for all instances
image = "Ubuntu-20.04-LTS-focal"

# masters
number_of_k8s_masters_no_floating_ip = 1
flavor_k8s_master_name               = "lrz.medium"

# nodes
number_of_k8s_nodes_no_floating_ip = 1
flavor_k8s_node_name               = "lrz.medium"

# networking
network_name           = "MWN"
subnet_cidr            = "192.168.0.0/17"
k8s_allowed_remote_ips = ["0.0.0.0/0"]

