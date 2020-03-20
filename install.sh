#!/usr/bin/env bash
# set -exo pipefail
set -x
CNAME1="ubuntu"
IMAGE1="ubuntu:bionic"
CNAME2="centos"
IMAGE2="images:centos/8"

echo "Hello there"
# snap install lxd --edge

if [ ! -z ${LINT} ]; then echo "Hello, world!"; fi


if [ ! -z ${IMAGE} ]; then   
    sudo apt remove -y --purge lxd lxd-client;
    sudo snap install lxd --stable;
    sudo lxd waitready;
    sudo lxd init --auto;
    # sudo chmod 666 /var/snap/lxd/common/lxd/unix.socket;  # avoids need for sudo on read
    sudo lxc list
fi

sudo lxc launch ${IMAGE1} ${CNAME1};
sudo lxc exec ${CNAME1} -- sh -c "lsb_release -a || cat /etc/redhat-release";
sudo lxc launch ${IMAGE2} ${CNAME2};
sudo lxc exec ${CNAME2} -- sh -c "lsb_release -a || cat /etc/redhat-release";
sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ubuntu.lxd";
sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ubuntu";
sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ${CNAME1}";
echo "sleep 10"
sleep 10
sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ubuntu.lxd";
sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ubuntu";
sudo lxc exec ${CNAME2} -- sh -c "ping -c 4 ${CNAME1}";
# snap install lxd --stable
sudo lxc list
lxc list

whoami
