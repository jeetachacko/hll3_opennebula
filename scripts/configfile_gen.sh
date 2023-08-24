#!/bin/bash

# !TODO! Update hardcoded values

chaincode=generator
tps=(50 100 300 500 800 1000)
num_entries=80
num_entries_per_tps=18

cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_gen.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

for i in $(seq 1 ${num_entries}); do
    selectedtps=${tps[ $RANDOM % ${#tps[@]} ]};
    for i in $(seq 1 ${num_entries_per_tps}); do
        configlines=( "    - label: common" "      txDuration: 10" "      rateControl:" "          type: fixed-rate" "          opts:" "            tps: ${selectedtps}" "      workload:" "        module: /caliper-workload/common.js" );
        printf '\n' >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
        printf '\n%s' "${configlines[@]}" >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
    done
done

#    - label: common
#      txDuration: 10
#      rateControl:
#          type: fixed-rate
#          opts:
#            tps: 800
#      workload:
#        module: /caliper-workload/common.js
