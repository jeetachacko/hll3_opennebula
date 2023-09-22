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
    if [ ! -f /home/ubuntu/hll3_opennebula/rlupdate.txt ]; then
        rm /home/ubuntu/hll3_opennebula/rlupdate.txt
        ./scripts/caliper_delete.sh
        sed -i -e '7,14d' /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml
        sleep 30s
    else
        >/home/ubuntu/hll3_opennebula/check.txt
        ./scripts/caliper_delete.sh
        ./scripts/network_delete.sh
        sleep 30s
        ./scripts/network_run.sh
        ./scripts/configfile_gen.sh
        sleep 30s
    fi
    #sed -i -e '7,14d' /home/ubuntu/hll3_opennebula/caliper/benchmarks/$chaincode/config.yaml
    #failcount=$((failcount+1))
    #echo "${failcount} Caliper Config File Completed - Caliper Restart" >> /home/ubuntu/hll3_opennebula/caliper/failure_logs.txt

done