#!/usr/bin/env bash
# set -exo pipefail
set -x
hap1="hap1"
hap2="hap2"
image="ubuntu:bionic"
ssh_pass="rootit"
# uuid=$(uuidgen)
hap1=$(uuidgen)
hap2=$(uuidgen)
nginx=$(uuidgen)
# CNAME2="centos"
# image="images:centos/8"
current_user=$(whoami)

sudo apt remove -y --purge lxd lxd-client;
sudo snap install lxd --stable  # --edge
sudo lxd waitready
sudo lxd init --auto

# sudo usermod --append --groups lxd "${current_user}"
# sudo chmod 666 /var/snap/lxd/common/lxd/unix.socket;  # avoids need for sudo on read


# sudo lxc launch ${IMAGE1} ${CNAME1};
# sudo lxc exec ${CNAME1} -- sh -c "lsb_release -a || cat /etc/redhat-release";
# sudo lxc launch ${IMAGE2} ${CNAME2};
# sudo lxc exec ${CNAME2} -- sh -c "lsb_release -a || cat /etc/redhat-release";
# sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ubuntu.lxd";
# sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ubuntu";
# sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ${CNAME1}";
# echo "sleep 10"
# sleep 10
# sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ubuntu.lxd";
# sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ubuntu";
# sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ${CNAME1}";
# # snap install lxd --stable
# sudo lxc list
# lxc list


containers[0]=hap1
containers[1]=hap2
containers[2]=nginx
for ${c} in "${containers[@]}"; do
    sudo lxc launch ${IMAGE1} ${CNAME1};
done

sleep 10

for ${c} in "${containers[@]}"; do
    sudo lxc exec ${CNAME1} -- sh -c "lsb_release -a || cat /etc/redhat-release";
    sudo lxc exec ${c} sed -i 's/^PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
    sudo lxc exec ${c} systemctl restart ssh 
    sudo lxc exec ${c} ssh-keygen -f ~/.ssh/id_app -N ''
    sudo lxc exec ${c} ssh-copy-id -i ~/.ssh/id_app user@host
    for ${ssh_host} in "${containers[@]}"; do
	if [ "${ssh_host}" != "${c}" ]; then
	    sudo lxc exec ${c} ping -c 2 ${ssh_host}
    	    sudo lxc exec ${c} sshpass -p ${ssh_pass} ssh-copy-id -i ~/.ssh/id_ed25519 root@${ssh_host}
            sudo lxc exec ssh root@${ssh_host} hostname
        fi
    done
done
