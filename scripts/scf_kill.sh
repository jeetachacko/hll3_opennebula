#!/usr/bin/env bash

pkill -9 -f ./scripts/scf_run.sh
pkill -9 -f ./scripts/caliper_run.sh
pkill -9 -f caliper-manager
pkill -9 -f caliper-logs.txt
pkill -9 -f scf_fab.py
pkill -9 -f ./scripts/k8s-updateconfig.sh