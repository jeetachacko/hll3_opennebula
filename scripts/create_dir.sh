#!/bin/bash

# !TODO! Update hardcoded values

# ips=("172.24.33.76" "172.24.33.105" "172.24.33.117" "172.24.33.130" "172.24.33.60")
# dirs=("hlf-orderer--ordorg1--orderer0" "hlf-orderer--ordorg1--orderer1" "hlf-orderer--ordorg1--orderer2" "hlf-peer--org1--peer0" "hlf-peer--org1--peer1" "hlf-peer--org2--peer0" "hlf-peer--org2--peer1")
# for ip in "${ips[@]}"
# do
#         # ssh -i ~/.ssh/id_rsa ubuntu@$ip "sudo rm -rf /mnt/hlf-*"
#         # ssh -i ~/.ssh/id_rsa ubuntu@$ip "sudo rm -rf /mnt/data/*"

#         for dir in "${dirs[@]}"
#         do
#                 ssh -i ~/.ssh/id_rsa ubuntu@$ip "mkdir -p /mnt/srv.nas/$dir"
#         done
# done

dirs=("hlf-orderer--ordorg1--orderer0" "hlf-orderer--ordorg1--orderer1" "hlf-orderer--ordorg1--orderer2" "hlf-peer--org1--peer0" "hlf-peer--org1--peer1" "hlf-peer--org2--peer0" "hlf-peer--org2--peer1")
for dir in "${dirs[@]}"
do
        mkdir -p /mnt/srv.nas/$dir
done