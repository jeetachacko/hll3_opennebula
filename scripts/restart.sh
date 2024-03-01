#!/bin/bash

cd /home/ubuntu/hll3_opennebula
>/home/ubuntu/hll3_opennebula/restart.txt
pkill -9 -f ./scripts/caliper_run.sh
pkill -9 -f caliper-manager
pkill -9 -f caliper-logs.txt