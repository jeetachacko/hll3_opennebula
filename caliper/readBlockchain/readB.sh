#!/usr/bin/env bash

#First run:
#python3 -m pip install -r requirements.txt
#npm install fabric-client@1.4.14
#rm -rf /tmp/hfc-cvs
#rm -rf /tmp/hfc-kvs

podcount=$(kubectl get pod -l app=caliper-worker --field-selector status.phase=Running --output json | jq -j '.items | length')
while [ $podcount -lt 10 ]
do
    sleep 30s
    podcount=$(kubectl get pod -l app=caliper-worker --field-selector status.phase=Running --output json | jq -j '.items | length')
done

kubectl logs -l app=caliper-worker --max-log-requests=10 --tail=5000 | grep " workerIndex=" > /home/ubuntu/hll3_opennebula/caliper/workerlog.txt
succ0=$(printf "%i" $(grep ' workerIndex= 0' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx0=$(printf "%i" $(grep ' workerIndex= 0' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency0=$(printf "%i" $(grep ' workerIndex= 0' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ1=$(printf "%i" $(grep ' workerIndex= 1' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx1=$(printf "%i" $(grep ' workerIndex= 1' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency1=$(printf "%i" $(grep ' workerIndex= 1' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ2=$(printf "%i" $(grep ' workerIndex= 2' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx2=$(printf "%i" $(grep ' workerIndex= 2' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency2=$(printf "%i" $(grep ' workerIndex= 2' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ3=$(printf "%i" $(grep ' workerIndex= 3' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx3=$(printf "%i" $(grep ' workerIndex= 3' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency3=$(printf "%i" $(grep ' workerIndex= 3' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ4=$(printf "%i" $(grep ' workerIndex= 4' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx4=$(printf "%i" $(grep ' workerIndex= 4' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency4=$(printf "%i" $(grep ' workerIndex= 4' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ5=$(printf "%i" $(grep ' workerIndex= 5' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx5=$(printf "%i" $(grep ' workerIndex= 5' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency5=$(printf "%i" $(grep ' workerIndex= 5' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ6=$(printf "%i" $(grep ' workerIndex= 6' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx6=$(printf "%i" $(grep ' workerIndex= 6' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency6=$(printf "%i" $(grep ' workerIndex= 6' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ7=$(printf "%i" $(grep ' workerIndex= 7' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx7=$(printf "%i" $(grep ' workerIndex= 7' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency7=$(printf "%i" $(grep ' workerIndex= 7' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ8=$(printf "%i" $(grep ' workerIndex= 8' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx8=$(printf "%i" $(grep ' workerIndex= 8' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency8=$(printf "%i" $(grep ' workerIndex= 8' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))
succ9=$(printf "%i" $(grep ' workerIndex= 9' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $5}' | tail -n 1))
totaltx9=$(printf "%i" $(grep ' workerIndex= 9' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $7}' | tail -n 1))
totalsucclatency9=$(printf "%i" $(grep ' workerIndex= 9' /home/ubuntu/hll3_opennebula/caliper/workerlog.txt | awk '{print $9}' | tail -n 1))

echo "succ0=$succ0=succ1=$succ1=succ2=$succ2=succ3=$succ3=succ4=$succ4=succ5=$succ5=succ6=$succ6=succ7=$succ7=succ8=$succ8=succ9=$succ9=totaltx0=$totaltx0=totaltx1=$totaltx1=totaltx2=$totaltx2=totaltx3=$totaltx3=totaltx4=$totaltx4=totaltx5=$totaltx5=totaltx6=$totaltx6=totaltx7=$totaltx7=totaltx8=$totaltx8=totaltx9=$totaltx9=totalsucclatency0=$totalsucclatency0=totalsucclatency1=$totalsucclatency1=totalsucclatency2=$totalsucclatency2=totalsucclatency3=$totalsucclatency3=totalsucclatency4=$totalsucclatency4=totalsucclatency5=$totalsucclatency5=totalsucclatency6=$totalsucclatency6=totalsucclatency7=$totalsucclatency7=totalsucclatency8=$totalsucclatency8=totalsucclatency9=$totalsucclatency9=" > /home/ubuntu/hll3_opennebula/caliper/workerlog.txt

totalsucc_org1=$(($succ0+$succ1+$succ2+$succ3+$succ4))
totalsucc_org2=$(($succ5+$succ6+$succ7+$succ8+$succ9))
totaltx_org1=$(($totaltx0+$totaltx1+$totaltx2+$totaltx3+$totaltx4))
totaltx_org2=$(($totaltx5+$totaltx6+$totaltx7+$totaltx8+$totaltx9))
echo "totalsucc_org1=$totalsucc_org1"
echo "totalsucc_org2=$totalsucc_org2"
echo "totaltx_org1=$totaltx_org1"
echo "totaltx_org2=$totaltx_org2"

# for (( i=0; i<10; i++ ));
# do
#     cd /home/ubuntu/hll3_opennebula/caliper/readBlockchain
#     rm data/*
#     rm data/csv/*
#     kubectl port-forward svc/hlf-ca--org1 7054:7054 -n default &
#     kubectl port-forward svc/hlf-peer--org1--peer0 7051:7051 -n default &
#     node read_blockchain.js
#     python3 convert_to_csv.py
#     python3 calculate.py
#     pkill -9 -f port-forward
#     pkill -9 -f port-forward
#     pkill -9 -f port-forward
#     sleep 20s
# done

# cd /home/ubuntu/hll3_opennebula/caliper/readBlockchain
# rm data/*
# rm data/csv/*
# kubectl port-forward svc/hlf-ca--org1 7054:7054 -n default &
# kubectl port-forward svc/hlf-peer--org1--peer0 7051:7051 -n default &
# node read_blockchain.js
# python3 convert_to_csv.py
# python3 calculate.py
# pkill -9 -f port-forward
# pkill -9 -f port-forward
# pkill -9 -f port-forward
# sleep 30s
# cd /home/ubuntu/selfConfiguringFabric