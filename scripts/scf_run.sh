#!/bin/bash

# !TODO! Update hardcoded values

chaincode=generator
tps=(50 100 200 400 800)

cd /home/ubuntu/hll3_opennebula

./scripts/network_delete.sh

sleep 10s

./scripts/network_run.sh

sleep 10s

./scripts/caliper_delete.sh

sleep 10s


cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_init.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

./scripts/caliper_run.sh $chaincode

cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_no_init.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml
count=0
while true; do
    if [ -f /home/ubuntu/hll3_opennebula/check.txt ]; then
        echo "Network Config Updated!"
        count=$((count+1))
    fi
    ./scripts/caliper_delete.sh
    #selectedtps=${tps[ $RANDOM % ${#tps[@]} ]}
    #sed -i "s/.*tps.*/            tps: $selectedtps/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml
    ./scripts/caliper_run.sh $chaincode
    sed -i 1,200d /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt
    if [ $count == 1 ]; then
        echo "Delete check file"
        rm /home/ubuntu/hll3_opennebula/check.txt
        count=0
    fi
    
done

cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_init.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

