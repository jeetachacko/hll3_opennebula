#!/usr/bin/env bash

FOLDER_NAME="config/templates"

# Move to fabric folder
cd `dirname $0`/../fabric

echo "Run channel read..."
helm template channel-read/ -f $FOLDER_NAME/network.yaml -f $FOLDER_NAME/crypto-config.yaml  -f $FOLDER_NAME/hostAliases.yaml | argo submit - --watch
