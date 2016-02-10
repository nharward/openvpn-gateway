#!/bin/sh

#
# See the openvpn man page for details on `--up`
#
/sbin/iptables -A FORWARD -o "${dev}" -i eth0 -s 192.168.2.0/24 -m conntrack --ctstate NEW -j ACCEPT
/sbin/iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
/sbin/iptables -A POSTROUTING -t nat -j MASQUERADE
