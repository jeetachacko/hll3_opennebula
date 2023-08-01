# HyperledgerLab

Hyperledger Testbed on Kubernetes Cluster: Automated Deployment of a Distributed Enterprise Blockchain Network for Analysis and Testing

## Summary

This repository contains scripts and helm charts we are developing to deploy a Hyperledger Testbed
on a Kubernetes cluster, itself running on cloud resources. For the latter, we assume, resources
provisioned via an OpenNebula environment.
A benchmarking tool: Hyperledger Caliper is configured to evaluate and collect metrics of the deployed network.

Scripts are based on the [HyperledgerLab](https://github.com/MSRG/HyperLedgerLab), [HyperledgerLab2](https://gitlab.lrz.de/ga32nac/hyperledgerlab2) and [HyperledgerLabOpenNebula](https://github.com/anandzol/HLL-OpenNebula) repositories.

## Quick Setup

For more details about the Quick Setup see: [HowToUse](docs/HowToUse.md).
1. Clone the repository
```shell
git clone git@github.com:jeetachacko/hll3_opennebula.git
cd ~/hll3_opennebula
```
2. Add the Open Nebula authentication details
```shell
vi ./openNebula/terraform-vm/terraform/config.tfvars
```
3. Install the prerequisites
```shell
./scripts/prerequisites1.sh
```
4. This script expects the entry of a password three times (any new password) - The script allows the use of Docker without sudo
```shell
./scripts/docker_setup.sh
```
5. Install further prerequisites
```shell
cd ~/hll3_opennebula
./scripts/prerequisites2.sh
```
6. Create VMs
```shell
cd scripts/
./init_opennebula_vms.sh 
```
7. Modify with the IPs of the newly created VMs
```shell
vi ./k8s_opennebula.sh
```
8. Set up the kubernetes cluster - If a lock error occurs then wait for a while and then rerun this script.
```shell
./k8s_opennebula.sh
```
9. ssh to the master node (usually the first VM) and set user permissions
```shell
ssh -i keypath ubuntu@ipaddress
sudo chown ubuntu /etc/kubernetes/admin.conf
exit
```
10. Edit the master node IP
```shell
vi ./k8s_opennebula_kubectl.sh
```
11. Start the kubernetes cluster
```shell
./k8s_opennebula_kubectl.sh
kubectl version
```
12. Set up and run the Hyperledger Fabric Network - Optionally modify configuration settings
```shell
cd ..
vi  ./fabric/network-configuration.yaml
./scripts/network_run.sh
```
13. Modify caliper configurations, add/modify workloads and set the git repository to save the caliper logs
```shell
vi ./fabric/network-configuration.yaml
ls ./caliper/benchmarks
cp ./caliper/git_sample.yaml ./caliper/git.yaml
vi ./caliper/git.yaml
```
14. Set up and run Caliper benchmarking system - Replace "fabcar" with the required chaincode name
```shell
./scripts/caliper_run.sh fabcar
```
## Deletion Scripts
```shell
./scripts/caliper_delete.sh
./scripts/network_delete.sh
./scripts/k8s_opennebula_delete.sh
./scripts/k8s_destroy.sh
```
## Supported Versions

- Kubernetes v1.21.1
- Docker 20.10.7
- Hyperledger Fabric: v2.x
- Hyerledger Caliper: v0.4.2
- Operating system: Software has been developed on Ubuntu 20.04 LTS

## Project Structure

A breakdown of the code structure: [DirectoryStructure](docs/DirectoryStructure.md)

## Comparison between HyperledgerLab I and II

A comparative table of the main features of HyperledgerLab I and II: [Version 1 and 2 Comparison](./docs/ComparativeTable.md).

## References

- Infrastructure provisioning with Terraform was inpired by a tutorial in the official Kubespray repository: [Kubernetes on OpenStack with Terraform](https://github.com/kubernetes-sigs/kubespray/tree/master/contrib/terraform/openstack)
- Running and operating the Hyperledger Fabric network in Kubernetes was highly inspired by the open source project [PIVT by Hakan Eryargi](https://github.com/hyfen-nl/PIVT)
