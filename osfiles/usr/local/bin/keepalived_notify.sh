#!/usr/bin/env /bash

if [ "$3" = "MASTER" ]; then
  echo "Master" >> /tmp/haproxy.log
  # touch /var/run/keepalived/$2
else
  echo "Not Master" >> /tmp/haproxy.log
  # rm /var/run/keepalived/$2
fi

ole=$1   # INSTANCE/GROUP
name=$2   # name of INSTANCE/GROUP
state=$3  # target state of transition(MASTER/BACKUP/FAULT)

echo "role: $role"
echo "name of role: $name"
echo "target state of role name: $state"
