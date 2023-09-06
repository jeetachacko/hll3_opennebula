#!/bin/bash

# !TODO! Update hardcoded values

#Multiple tps - Dynamic Workload

# chaincode=generator
# tps=(100 500 800)
# num_entries=6
# num_entries_per_tps=60

# cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_gen.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

# for i in $(seq 1 ${num_entries}); do
#     selectedtps=${tps[ $RANDOM % ${#tps[@]} ]};
#     for i in $(seq 1 ${num_entries_per_tps}); do
#         configlines=( "    - label: common" "      txDuration: 10" "      rateControl:" "          type: fixed-rate" "          opts:" "            tps: ${selectedtps}" "      workload:" "        module: /caliper-workload/common.js" );
#         printf '\n' >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
#         printf '\n%s' "${configlines[@]}" >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
#     done
# done

#Single tps - Uniform Workload
chaincode=generator
tps=500
num_entries=360

cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_gen.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

for i in $(seq 1 ${num_entries}); do
        configlines=( "    - label: common" "      txDuration: 10" "      rateControl:" "          type: fixed-rate" "          opts:" "            tps: ${tps}" "      workload:" "        module: /caliper-workload/common.js" );
        printf '\n' >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
        printf '\n%s' "${configlines[@]}" >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
done