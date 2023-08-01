# create ~/.kube directory
mkdir -p ~/.kube

# copy the kubeconfig file
scp ubuntu@172.24.33.42:/etc/kubernetes/admin.conf ~/.kube/config
# change the above IP to point to the control plane node, from where the admin.conf is to be copied

# change ownership
chown $USER: ~/.kube/config

# Install agro controller with the configured kubectl
kubectl create namespace argo
kubectl apply -n argo -f ../fabric/argo/install.yaml
kubectl create rolebinding default-admin --clusterrole=admin --serviceaccount=default:default


