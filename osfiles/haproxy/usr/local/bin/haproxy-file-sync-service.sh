#!/usr/bin/env bash

while [ true ]; do
 sleep 15  # sync every 15 seconds
 # do what you need to here
echo "running sync"
./osync.sh --initiator=/jtmp --target=ssh://root@hap2c1:22//jtmp
done
