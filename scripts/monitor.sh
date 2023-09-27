#!/usr/bin/env bash

# !TODO! Update hardcoded values
# TODO Add Fabric Restart



cd /home/ubuntu/hll3_opennebula

count=0
failcount=0
while true; do
    #if [ -f /home/ubuntu/hll3_opennebula/check.txt ]; then
    #    echo "Network Config Updated!"
    #    count=$((count+1))
    #fi

    log_before=$((grep '| common |' | wc -l) < /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt)
    sleep 240s
    log_after=$((grep '| common |' | wc -l) < /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt)
    diff=$(($log_after - $log_before))
    succ=$(printf "%i" $(grep '| common |' /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt | awk '{print $4}' | tail -n 1))
    echo "Caliper Failure Status - diff: {$diff}, succ: {$succ}"
    if [ $diff == 0 ] || [ $succ == 0 ]; then
        if [ ! -f /home/ubuntu/hll3_opennebula/check.txt ] && [ ! -f /home/ubuntu/hll3_opennebula/check_caliper.txt ]; then
            echo "Caliper Failed"
            failcount=$((failcount+1))
            echo "${failcount} Failed - Fabric & Caliper Restart - Failure Status - diff: {$diff}, succ: {$succ}" >> /home/ubuntu/hll3_opennebula/caliper/failure_logs.txt
            pkill -9 -f ./scripts/caliper_run.sh
            pkill -9 -f caliper-manager
            pkill -9 -f caliper-logs.txt
            sleep 420s
        fi
    fi
    #sed -i 1,200d /home/ubuntu/hll3_opennebula/caliper/caliper-logs.txt
    #if [ $count == 1 ]; then
    #    echo "Delete check file"
    #    rm /home/ubuntu/hll3_opennebula/check.txt
    #    count=0
    #fi
    
done

