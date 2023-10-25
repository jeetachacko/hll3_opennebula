#!/bin/bash

# !TODO! Update hardcoded values

#[100, 100, 100, 100, 100, 100, 100, 100, 100, 100]
#[60, 60, 60, 60, 60, 60, 60, 60, 60, 60]
learnedrate="[100, 100, 100, 100, 100, 100, 100, 100, 100, 100]"

sed -i "s/.*var wlearnedrate = .*/          var wlearnedrate = $learnedrate/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/getValues.js

CHAINCODE_NAME="generator"

# Move to caliper folder
cd `dirname $0`/../caliper

kubectl create configmap getvalues --from-file=./benchmarks/$CHAINCODE_NAME/getValues.js -o yaml --dry-run=client | kubectl apply -f -

#kubectl create configmap workload --from-file=./benchmarks/$CHAINCODE_NAME -o yaml --dry-run=client | kubectl apply -f -