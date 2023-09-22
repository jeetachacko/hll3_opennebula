#!/usr/bin/env bash

pkill -9 -f ./scripts/scf_run.sh
pkill -9 -f ./scripts/caliper_run.sh
pkill -9 -f ./scripts/network_run.sh
pkill -9 -f caliper-manager
pkill -9 -f caliper-logs.txt
pkill -9 -f scf_fab.py
pkill -9 -f scf_fab_predict.py
pkill -9 -f ./scripts/k8s-updateconfig.sh
pkill -9 -f wandb-service
pkill -9 -f ./scripts/monitor.sh
rm /home/ubuntu/hll3_opennebula/check.txt
rm /home/ubuntu/hll3_opennebula/tpsupdate.txt
rm /home/ubuntu/hll3_opennebula/rlupdate.txt
pkill -9 -f ./scripts/scf_run.sh
pkill -9 -f ./scripts/network_run.sh
pkill -9 -f ./scripts/configfile_gen.sh
