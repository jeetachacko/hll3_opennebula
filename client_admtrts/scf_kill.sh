#!/usr/bin/env bash

pkill -9 -f ./scripts/scf_run.sh
pkill -9 -f ./scripts/caliper_run.sh
pkill -9 -f ./scripts/network_run.sh
pkill -9 -f caliper-manager
pkill -9 -f caliper-logs.txt
pkill -9 -f caliper-worker
pkill -9 -f workerlog.txt
pkill -9 -f scf_fab.py
pkill -9 -f scf_fab_predict.py
pkill -9 -f ./scripts/k8s-updateconfig.sh
pkill -9 -f wandb-service
pkill -9 -f ./scripts/monitor.sh
rm /home/ubuntu/hll3_opennebula/check.txt
rm /home/ubuntu/hll3_opennebula/check_caliper.txt
rm /home/ubuntu/hll3_opennebula/tpsupdate.txt
rm /home/ubuntu/hll3_opennebula/rlupdate.txt
rm /home/ubuntu/hll3_opennebula/parser.txt
rm /home/ubuntu/hll3_opennebula/caliper/blockreader-logs.txt
rm /home/ubuntu/hll3_opennebula/caliper/workerlog.txt
pkill -9 -f ./scripts/scf_run.sh
pkill -9 -f ./scripts/network_run.sh
pkill -9 -f ./scripts/configfile_gen.sh
pkill -9 -f port-forward
pkill -9 -f read_blockchain.js
pkill -9 -f convert_to_csv.py
pkill -9 -f calculate.py
