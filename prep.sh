#!/usr/bin/env bash
set -e
# copy haproxy-simple.cfg and gen cert for it

dnf install haproxy
cp /etc/haproxy/haproxy.cfg /etc/haproxy/haproxy.cfg.o
cp haproxy-simple.cfg /etc/haproxy/haproxy.cfg
mkdir -p /etc/haproxy/pki
cp least_sessions.lua /etc/haproxy/pki/
mkdir /etc/haproxy/pki
cd /etc/haproxy/pki
openssl req -subj '/CN=example/O=Utah/C=US' -new -newkey rsa:2048 -sha256 -days 3650 -nodes -x509 -keyout server.key -out server.crt
cat server.crt server.key > /etc/haproxy/pki/server.pem
haproxy -c -V -f /etc/haproxy/haproxy.cfg
systemctl start haproxy
systemctl enable haproxy
curl -k https://www.example.com:10443 --resolve www.example.com:10443:127.0.0.1  # 127.0.0.1 is your hap vserver ip
curl -k http://www.example.com:10080 --resolve www.example.com:10080:127.0.0.1
