     #!/bin/bash

# !TODO! Update hardcoded values

cd /home/ubuntu/hll3_opennebula
chaincode=generator
./scripts/network_delete.sh
sleep 10s
./scripts/network_run.sh
sleep 10s
./scripts/caliper_delete.sh
sleep 60s

./scripts/configfile_gen.sh
#failcount=0
while true; do
    ./scripts/caliper_run.sh $chaincode 
    if [ ! -f /home/ubuntu/hll3_opennebula/tpsupdate.txt ]; then
        rm /home/ubuntu/hll3_opennebula/tpsupdate.txt
        ./scripts/caliper_delete.sh
        ./scripts/configfile_gen.sh
        sed -i -e '7,14d' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
        sleep 30s
    else
        >/home/ubuntu/hll3_opennebula/check.txt
        ./scripts/caliper_delete.sh
        ./scripts/network_delete.sh
        sleep 30s
        ./scripts/network_run.sh
        if grep -q 'initLedger' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml; then
            echo found
        else
            sed -i '7i \    - label: initLedger' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
            sed -i '8i \      txNumber: 10000' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
            sed -i '9i \      rateControl:' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
            sed -i '10i \          type: fixed-rate' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
            sed -i '11i \          opts:' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
            sed -i '12i \            tps: 300' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
            sed -i '13i \      workload:' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
            sed -i '14i \        module: /caliper-workload/initLedger.js' /home/ubuntu/hll3_opennebula/caliper/benchmarks/generator/config.yaml
        fi
        sleep 30s
    fi

done