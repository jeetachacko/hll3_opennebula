## **Quickstart Guide**

This quickstart will walk you through all the steps to run HyperledgerLab II.
After completing all the steps in this tutorial, a highly configurable Hyperledger Fabric network will be running on a Kubernetes cluster and a report of a bechmarking tool: Hyperledger Caliper evaluating the Heyperledger Fabric network will be generated.

1. Create a a key pair

   - Run Command: `ssh-keygen -t rsa -f ~/.ssh/id_rsa`
   - Import the key pair to OpenNebula
     - Go to https://cloud.dis.cit.tum.de/#settings-tab
     - Under "Update SSH key" tab, paste the public key.

- Create the instance/VM (Ubuntu 20.04) via dashboard. This will be our ansible host.
 
- After launching the instance, wait approximately 90 seconds until the instance has the active status and the IP address is reachable.

- From now on, all the commands are executed from CLI
  - `ssh -i ~/.ssh/id_rsa ubuntu@<instance_ip>`

- Once logged in, Copy your private key(from step 1) as  ~/.ssh/id_rsa. We use the same keypair for
  VM creation (as OpenNebula VMs only support RSA-1 keys and the new keys are parsed weirdly under
  authorized_keys)

3. Clone the repository

   ```
   git clone --recursive https://gitlab.lrz.de/anandzol/HLL-OpenNebula.git
   cd HLL-OpenNebula/HyperLedgerLab
   ```

4. Add OpenNebula authentication details and Provision infrastructure and setup a Kubernetes cluster

   - Check or edit the infrastructure configuration in
     [./openNebula/terraform-vm/terraform/config.tfvars](../openNebula/terraform-vm/terraform/config.tfvars).
     The configuration variables that is required are "ON_USERNAME, ON_PASSWD, ON_GROUP". Other
     variables are self-explanatory. ON_VM_COUNT controls the number of k8 nodes for HLL. Please
     check the README under terraform-vm folder for details on  other variants of VMs. 

   
   - Run Command: `./init_opennebula_vms.sh` under scripts folder (type "yes" when prompted)
   - **Estimated execution time:** 10 minutes
   - What will happen ?

     - Installs the required tools
     - Provisions infrastructure on OpenNebula cluster using Terraform

   Once the script finish running, the newly generated  [./openNebula/terraform-vm/terraform/ansible/inventory.cfg](../openNebula/terraform-vm/terraform/ansible/inventory.cfg) will have the list of IPs of newly created VMs

     - Copy the IPs and paste them seperated by space on IPS variable (L24) inside
       `k8s_opennebula.sh` under scripts folder. The control plane nodes are the first (n/2 + 1) of this
       variable, chosen arbitrarily.
     
     - Now run the command `./k8s_opennebula.sh`. This runs approximately for 15 minutes and will deploy k8s over the newly created VMs.There might be two quirky issues encountered during this process. 1) ssh error which can be due to ssh-agent inactivity. To fix this, run `eval $(ssh-agent -s)` and `ssh-add ~/.ssh/id_rsa`. 2) This kubespray error occurs more frequently - "Could not get lock /var/lib/dpkg/lock-frontend. It is held by process 2714 (unattended-upgr)". upon which we can wait for sometime and run the script again to fix this error or preferably ssh into the nodes (if the failure is in node-1, ssh into the first ip of IPS variable, switch to root) and kill the process holding the lock (run `ps -aef | grep unattended` and then `kill <pid>`), then exit the node, rerun the script again. 

   Once this is over, we proceed to install kubectl client in our system (ansible host). To do this:
        
     - SSH into one of the master nodes. usually the first IP of the former IPS variable works. 
     - switch to root user and run `chown ubuntu /etc/kubernetes/admin.conf` and exit the master
       node. 
     - Now update the master node IP (L5) in the script `./k8s_opennebula_kubectl` and run the
       script.
     
  Now the Kubectl client is installed and configured in our node and we can access the nodes and
  other kubernetes resources information from our Ansible host.  



   - Check for running Kubernetes cluster and for the good configuration of kubectl by running `kubectl version`.
     You should see a similar output:

     ```
     Client Version: version.Info{Major:"1", Minor:"21", GitVersion:"v1.21.0", GitCommit:"cb303e613a121a29364f75cc67d3d580833a7479", GitTreeState:"clean", BuildDate:"2021-04-08T16:31:21Z", GoVersion:"go1.16.1", Compiler:"gc", Platform:"linux/amd64"}
     Server Version: version.Info{Major:"1", Minor:"20", GitVersion:"v1.20.4", GitCommit:"e87da0bd6e03ec3fea7933c4b5263d151aafd07c", GitTreeState:"clean", BuildDate:"2021-02-18T16:03:00Z", GoVersion:"go1.15.8", Compiler:"gc", Platform:"linux/amd64"}
     ```

   - To destroy the infrastructure provisioned:

     - Run command: `./scripts/k8s_opennebula_delete.sh` and then `./scripts/k8s_destroy.sh` for
       undeploying k8s and deleting the VMs created by terraform. 

6. Install Hyperledger Fabric on the running Kubernetes cluster

   - The main Hyperledger Fabric components are defined in a Helm chart for Kubernetes.
   - The network configuration can be changed in [./fabric/network-configuration.yaml](../fabric/network-configuration.yaml).
   - What can be changed?

     | Configuration                | description                                                                                                                                                                                    |
     | ---------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
     | `Fabric container images`    | You can define original or custom fabric and caliper container images                                                                                                                          |
     | `Fabric Network Config`      | You can define number of orgs, peer per orgs and orderers                                                                                                                                      |
     | `Fabric Orderer Type`        | Available types are "solo" and "etcdraft"                                                                                                                                                      |
     | `State Database`             | Otions are "goleveldb", "CouchDB". goleveldb - default state database stored in goleveldb. CouchDB - store state database in CouchDB                                                           |
     | `Batch Timeout & Batch Size` | Batch Timeout: amount of time to wait before creating a batch & Batch Size: number of messages batched into a block                                                                            |
     | `Fabric tls enabled`         | Wether TLS is enabled in the whole network                                                                                                                                                     |
     | `Endorsement policy`         | Customize the endorsement policy. Example: "OR('Org1MSP.member', AND('Org2MSP.member', 'Org3MSP.member'))" or "OutOf(2, 'Org1MSP.member', 'Org2MSP.member', 'Org3MSP.member')"                 |
     | `Channel configuration`      | You define the channels and chaincode definitions in the respective channel                                                                                                                    |
     | `Logging Level`              | Logging severity levels are specified using case-insensitive strings chosen from FATAL, PANIC, ERROR, WARNING, INFO or DEBUG                                                                   |
     | `use_docker_credentials`     | If true then Kubernetes will pull the images from a private docker account. Please refer to the first point of **Common Errors** section to create the docker credential secret in Kubernetes. |

   - Run command: `./scripts/network_run.sh`
   - What will happen ?

     - Installs the helm chart containing all necessary components of the Hyperledger Fabric network.
       - **Estimated execution time:** 40 seconds
     - Creates channel and join all peers to it
       - **Estimated execution time:** 90 seconds per channel
     - Installs all chaincodes on all peers of the respective channel
       - **Estimated execution time:** 120 seconds per chaincode

   - To delete Hyperledger Fabric network
     - Run command: `./scripts/network_delete.sh` to delete all Kubernetes components used to run the Hyperledger Fabric network.

7. Run Hyperledger Caliper

   - Hyperledger Caliper folder contains the following configuration

     - Network Configuration: automatically generated from the network configurations defined in [./fabric/network-configuration.yaml](../fabric/network-configuration.yaml).
     - Workload module and benchmark configuration files should be found in a folder with the respective chaincode name under [./caliper/benchmarks](../caliper/benchmarks).

   - Before running Hyperledger Caliper:

     - Create a git repository to save the generated report.html and the caliper logs.
     - Create a project access token for the project by following this [Gitlab tutorial](https://docs.gitlab.com/ee/user/project/settings/project_access_tokens.html#creating-a-project-access-token).
     - Following [./caliper/git_sample.yaml](../caliper/git_sample.yaml) as a template, create a [./caliper/git.yaml](../caliper/git.yaml) file where you put information about the git repository just created.

   - Run Hyperledger Caliper

     - Run command: `./scripts/caliper_run.sh <chaincode_folder> ` e.g `./scripts/caliper_run.sh fabcar`
     - Workflow:

       - Runs mosquitto: a lightweight open source message broker that Implements MQTT protocol to carry out messaging between caliper manager and worker(s).
       - Adds the workload Module, Benchmark configuration and Network Configuration as configmap.
       - Runs Caliper Manager
       - Runs Caliper Worker(s)
       - Logs into caliper manager pod

     - **Estimated execution time:** It depends of the actual workload: how many workers, rounds, transactions etc. Nevertheless, the approximate time until the start of the test rounds is 180 seconds.
     - Caliper logs and the report generated are pushed to the git repository under the respective timestamped folder.
     - To log in to the Caliper Manager to view the Caliper report or to one Caliper Worker to investigate a failed transaction:
       1. `kubectl get po`
       2. Copy the pod name of the Caliper Manager or one of the Caliper Workers
       3. `Kubectl logs -f <caliper_pod_name>`

   - To delete Hyperledger caliper:
     - Run command: `./scripts/caliper_delete.sh` to delete all Kubernetes components used to run caliper.

## **Troubleshooting**

1. **Issue:** ErrImagePull: rpc error: code = Unknown desc = Error response from daemon: toomanyrequests: You have reached your pull rate limit. You may increase the limit by authenticating and upgrading: https://www.docker.com/increase-rate-limit <br />
   **Explanation:** Docker introduced a pull rate limit. For anonymous usage, the rate limit is fixed to 100 container image requests per six hours, and for free Docker accounts 200 container image requests per six hours. For paid docker account there is however no limit. <br />
   **Workaround** To mitigate the issue, you can login into you free or paid docker account. To do so you need to create a Kubernetes secret based on existing Docker credentials. A Kubernetes cluster uses the Secret of kubernetes.io/dockerconfigjson type to authenticate with a container registry to pull a private image. Please enter this command

   ```
   kubectl create secret docker-registry regcred --docker-server=https://index.docker.io/v2/ \ --docker-username=<username> --docker-password=<docker-password> \ --docker-email=<docker-email>
   ```

   Then in [./fabric/network-configuration.yaml](../fabric/network-configuration.yaml), you should set `use_docker_credentials` to `true`.

2. **Issue:** Using kubectl you get "The connection to the server 172.24.35.65:6443 was refused - did you specify the right host or port?" <br />
   **Explanation:** This error indicates that kubectl is not configured to point to the installed Kubernetes cluster. The ansible playbook mentioned in the workaround will solve the problem. <br />
   **Workaround:** from [./terraform](../terraform), run the command `ansible-playbook -i hosts ../playbook.yaml`

3. **Issue:** Error: Error waiting for instance (23bde629-afb5-4c09-a6bc-8ad99aee2d6e) to become ready: unexpected state 'ERROR', wanted target 'ACTIVE'. last error: %!s(<nil>)
   <br />
   **Explanation:** One possible cause of this issue is that no enough resources on the OpenStack project are found to create one or more instances.<br />
   **Workaround:** Go to OpenStack dashboard to check the error message. Normally, this problem is not related to HyperledgerLab2.

4. **Issue:** Error: Unable to create openstack_compute_keypair_v2 kubernetes-hll: Expected HTTP response code [200 201] when accessing [POST http://172.24.18.142:8774/v2.1/13291ac9bdb64f44ab84a01d319dd9fb/os-keypairs], but got 409 instead
   │ {"conflictingRequest": {"message": "Key pair 'kubernetes-hll' already exists.", "code": 409}} <br />
   **Explanation:** You are trying the create a new Kubernetes cluster in the same Openstack project using the same cluster name.<br />
   **Workaround:** In [./terraform/cluster.tfvars](../terraform/cluster.tfvars), enter a different cluster name than the cluster running in your Openstack project.
