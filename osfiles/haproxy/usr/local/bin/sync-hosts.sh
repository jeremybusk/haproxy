#!/usr/bin/env bash
# Sync files by most recent timestamp.
# For more sophisticated tool use unison or osync - apt install unison

host="10.64.5.232"
ssh_port=22

files=(
    "/etc/haproxy/haproxy.cfg"
    "/etc/keepalived/keepalived.conf"
    "/usr/local/bin/keepalived_notify.sh"
    "/usr/local/bin/chkha.sh"
)

function sync_files {
    for file in "${files[@]}"; do
        echo $file
        # rsync -e "ssh -p ${ssh_port}" --update -raz --progress ${host}:/tmp2/* /tmp2/
        # rsync -e "ssh -p ${ssh_port}" --update -raz --progress /tmp2/* ${host}:/tmp2/
        rsync -e "ssh -p ${ssh_port}" --update -raz --progress ${host}:${file} ${file}
        rsync -e "ssh -p ${ssh_port}" --update -raz --progress ${file} ${host}:${file}
    done
}

while [ true ]; do
     # do what you need to here
     echo "running sync"
     sync_files
     sleep 15
done
