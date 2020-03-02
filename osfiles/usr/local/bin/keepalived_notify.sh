#!/usr/bin/env /bash

if [ "$3" = "MASTER" ]; then
  echo "Master" >> /tmp/haproxy.log
  # touch /var/run/keepalived/$2
else
  echo "Not Master" >> /tmp/haproxy.log
  # rm /var/run/keepalived/$2
fi
