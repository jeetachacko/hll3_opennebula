#!/bin/bash

# !TODO! Update hardcoded values

#Single tps - Uniform Workload
chaincode=generator
selectedtps=$1
num_entries=360

cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_gen.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

for i in $(seq 1 ${num_entries}); do
        configlines=( "    - label: common" "      txDuration: 10" "      rateControl:" "          type: fixed-rate" "          opts:" "            tps: ${selectedtps}" "      workload:" "        module: /caliper-workload/common.js" );
        printf '\n' >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
        printf '\n%s' "${configlines[@]}" >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
done

#Multiple tps - Dynamic Workload

# chaincode=generator
# tps=(100 300 500)
# num_entries=6 #2hours  
# num_entries_per_tps=120

# cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_gen.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

# for i in $(seq 1 ${num_entries}); do
#     selectedtps=${tps[ $RANDOM % ${#tps[@]} ]};
#     for i in $(seq 1 ${num_entries_per_tps}); do
#         configlines=( "    - label: common" "      txDuration: 10" "      rateControl:" "          type: fixed-rate" "          opts:" "            tps: ${selectedtps}" "      workload:" "        module: /caliper-workload/common.js" );
#         printf '\n' >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
#         printf '\n%s' "${configlines[@]}" >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
#     done
# done

# #Single tps - Uniform Workload
# chaincode=generator
# tps=(100 50 300)
# selectedtps=${tps[ $RANDOM % ${#tps[@]} ]};
# num_entries=360

# cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_gen.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

# for i in $(seq 1 ${num_entries}); do
#         configlines=( "    - label: common" "      txDuration: 10" "      rateControl:" "          type: fixed-rate" "          opts:" "            tps: ${selectedtps}" "      workload:" "        module: /caliper-workload/common.js" );
#         printf '\n' >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
#         printf '\n%s' "${configlines[@]}" >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
# done

#New tps every 20mins
# chaincode=generator
# tps=(50 100 300)
# selectedtps=${tps[ $RANDOM % ${#tps[@]} ]};
# num_entries=120

# cp /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config_gen.yaml /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml

# for i in $(seq 1 ${num_entries}); do
#         configlines=( "    - label: common" "      txDuration: 10" "      rateControl:" "          type: fixed-rate" "          opts:" "            tps: ${selectedtps}" "      workload:" "        module: /caliper-workload/common.js" );
#         printf '\n' >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
#         printf '\n%s' "${configlines[@]}" >> /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml;
# done