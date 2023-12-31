#!/usr/bin/env bash

FOLDER_NAME="config/templates"

# Move to fabric folder
cd `dirname $0`/../fabric

#kubectl apply -f /home/ubuntu/hll3_opennebula/fabric/hlf-kube/templates/pv-volume.yaml

# Create config files using helm template
echo "-- creating config files --"
helm template config-template/ -f network-configuration.yaml --output-dir .

# create necessary stuff: crypto-config files, channel-artifacts and chaincode compression 
../scripts/init_network.sh ./$FOLDER_NAME/ ./chaincode/

# Luanch the Raft based Fabric network in broken state
helm install hlf-kube ./hlf-kube/ -f $FOLDER_NAME/network.yaml -f $FOLDER_NAME/crypto-config.yaml --set peer.launchPods=false --set orderer.launchPods=false 

# Collect the host aliases
../scripts/collect_host_aliases.sh ./$FOLDER_NAME/

# Update the network with host aliases
helm upgrade hlf-kube ./hlf-kube/ -f $FOLDER_NAME/network.yaml -f $FOLDER_NAME/crypto-config.yaml -f $FOLDER_NAME/hostAliases.yaml 

# Check if pods exist and running
# we don't check for CA because if peers and orderers are running then CA pods are also running. 
echo "Wait until orderer pods are all running..."
while [[  $(kubectl get pods -l name=hlf-orderer -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') == *"False"* ]] || [[ -z $(kubectl get  pods -l name=hlf-orderer) ]] ; do echo "waiting for orderer pods..." && sleep 4; done

echo "Wait until peer pods are all running..."
while [[ $(kubectl get pods -l name=hlf-peer -o 'jsonpath={..status.conditions[?(@.type=="Ready")].status}') == *"False"* ]] || [[ -z $(kubectl get  pods -l name=hlf-peer) ]] ; do echo "waiting for peer pods..." && sleep 4; done

sleep 20s

echo "Run channel flow..."
helm template channel-flow/ -f $FOLDER_NAME/network.yaml -f $FOLDER_NAME/crypto-config.yaml -f $FOLDER_NAME/hostAliases.yaml | argo submit - --watch

sleep 5 ∏

echo "Run chaincode flow..."
helm template chaincode-flow/ -f $FOLDER_NAME/network.yaml -f $FOLDER_NAME/crypto-config.yaml  -f $FOLDER_NAME/hostAliases.yaml | argo submit - --watch

