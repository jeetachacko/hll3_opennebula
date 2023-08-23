#!/bin/bash

# !TODO! Update hardcoded values

chaincode=generator
tps=(50 100 150 200 250 300)
num_entries=360

cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_gen.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

for i in $(seq 1 ${num_entries}); do
    selectedtps=${tps[ $RANDOM % ${#tps[@]} ]};
    configlines=( "    - label: common" "      txDuration: 10" "      rateControl:" "          type: fixed-rate" "          opts:" "            tps: ${selectedtps}" "      workload:" "        module: /caliper-workload/common.js" );
    printf '\n' >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
    printf '\n%s' "${configlines[@]}" >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
done

#    - label: common
#      txDuration: 10
#      rateControl:
#          type: fixed-rate
#          opts:
#            tps: 800
#      workload:
#        module: /caliper-workload/common.js
