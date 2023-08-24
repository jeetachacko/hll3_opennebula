#!/bin/bash

# !TODO! Update hardcoded values

cd /home/ubuntu/hll3_opennebula
chaincode=generator
./scripts/network_delete.sh
sleep 10s
./scripts/network_run.sh
sleep 10s
./scripts/caliper_delete.sh
sleep 10s

./scripts/configfile_gen.sh
failcount=0
while true; do
    ./scripts/caliper_run.sh $chaincode 
    ./scripts/caliper_delete.sh
    sleep 60s
    ./scripts/configfile_gen.sh
    sed -i -e '7,14d' /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml
    failcount=$((failcount+1))
    echo "${failcount} Caliper Config File Completed - Caliper Restart" >> /home/ubuntu/hll3_opennebula/caliper/failure_logs.txt
done