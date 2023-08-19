#!/bin/bash

# !TODO! Update hardcoded values

chaincode=generator
tps=(50 100 150 200 250 300)

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

    timeout 360s ./scripts/caliper_run.sh $chaincode ; if [ $? -eq 124 ] ; then succ=0 ; else succ=$(printf "%i" $(grep '| common |' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt | awk '{print $4}' | tail -n 1)) ; fi
    #succ=$(printf "%i" $(grep '| common |' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt | awk '{print $4}' | tail -n 1))
    if [ $succ == 0 ]; then
        ./scripts/caliper_delete.sh
        sleep 30s
        timeout 360s ./scripts/caliper_run.sh $chaincode ; if [ $? -eq 124 ] ; then succ=0 ; else succ=$(printf "%i" $(grep '| common |' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt | awk '{print $4}' | tail -n 1)) ; fi
    fi

    if [ $succ == 0 ]; then
        ./scripts/network_delete.sh
        ./scripts/caliper_delete.sh
        sleep 30s
        ./scripts/network_run.sh
        sleep 10s
        timeout 360s ./scripts/caliper_run.sh $chaincode ; if [ $? -eq 124 ] ; then succ=0 ; else succ=$(printf "%i" $(grep '| common |' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt | awk '{print $4}' | tail -n 1)) ; fi
    fi
    sed -i 1,200d /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt
    if [ $count == 1 ]; then
        echo "Delete check file"
        rm /home/ubuntu/hll3_opennebula/check.txt
        count=0
    fi
    
done

cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_init.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

