#!/bin/bash

# parses anchor peers for an organization from configtx.yaml, 
# attaches it to config.json and writes output to updated_config.json

#if test "$#" -ne 6; then
echo "usage: update_config.sh <orgID> <configtx.yaml> <config.json> <updated_config.json> <key> <value>" 
#   exit 2
#fi

# switch to caller directory so we can work with relative paths
cd $(pwd)

# exit when any command fails
set -e
# set -x

orgID=$1
configtx_yaml=$2
config_json=$3
updated_config_json=$4
key=$5
value=$6
workdir="/tmp"

echo "starting update config.json"
echo "key: $key"
echo "value: $value"

#jq "$key = $value" "$config_json" > "$updated_config_json" &&
if [ "$key" = ".channel_group.groups.Orderer.values.BatchSize.value.preferred_max_bytes" ] || [ "$key" = ".channel_group.groups.Orderer.values.ConsensusType.value.metadata.options.snapshot_interval_size" ]; then
  echo "Multiplying $key with 1000000 to get bytes"
  multiplier=1000000
  value=$(( $6 * $multiplier ))
  jq ''$(echo $key)' = "'$(echo $value)'"' "$config_json" > "$updated_config_json"
else
  jq ''$(echo $key)' = "'$(echo $value)'"' "$config_json" > "$updated_config_json"
fi

#jq ''$(echo $key)' = "'$(echo $value)'"' "$config_json" > "$updated_config_json" &&
#echo "updated config.json"
echo >&2 "-- set {{ $key }} to {{ $value }} and wrote to /work/updated_config.json" 

# parse AnchorPeers from configtx.yaml
#echo $(yq --version)
#anchor_peers=$(yq eval -j '.Organizations[] | select (.Name == "'$(echo $orgID)'") | .AnchorPeers' "$configtx_yaml")

#if [ -z "$anchor_peers" ]; then
#   echo "-- couldn't parse AnchorPeers for organization $orgID from $configtx_yaml" 
#   exit 1
#fi

#echo "-- parsed AnchorPeers for organization $orgID from $configtx_yaml: $anchor_peers"

# convert keys to lower case in AnchorPeers
#anchor_peers=$(echo "$anchor_peers" | jq -c '.[] | with_entries(.key |=ascii_downcase)' | jq -cs .)
#echo "-- converted keys in AnchorPeers to lower case: $anchor_peers"

#jq '.channel_group.groups.Application.groups.'$(echo $orgID)'.values += 
#        {"AnchorPeers":{"mod_policy": "Admins","value":{"anchor_peers": '$(echo $anchor_peers)'},"version": "0"}}' \
#        "$config_json" > "$updated_config_json"
#echo "-- attached anchor peers for organization $orgID and wrote to $updated_config_json"


