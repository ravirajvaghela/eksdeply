#!/bin/bash

dateofdeploy=$1
isnewberunning="false"
echo "is it running ? $isnewberunning"
retrybecount=0
while [[ "$isnewberunning" != *"true"* ]]; do
  if [ "$retrybecount" = "400" ]; then
    exit 1;
  fi
  sleep 10;
  ((retrybecount++))
  echo "$dateofdeploy running checking : $retrybecount times"
  isnewberunning=$(kubectl get pods --selector=date="$dateofdeploy" -n accis-app -o jsonpath='{.items[*].status.containerStatuses[0].ready}')
  echo "is it running ? $isnewberunning"
done