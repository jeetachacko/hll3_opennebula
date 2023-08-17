#!/bin/bash

# !TODO! Update hardcoded values

chaincode=generator
tps=(50 100 150 200 250 300 350 400 450 500)

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

while true; do
    ./scripts/caliper_delete.sh
    ./scripts/caliper_run.sh $chaincode
    selectedtps=${tps[ $RANDOM % ${#tps[@]} ]}
    sed -i "s/.*tps.*/            tps: $selectedtps/" /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml
    sed -i 1,200d /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt
done

cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_init.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

