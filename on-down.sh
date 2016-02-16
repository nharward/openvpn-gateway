#!/bin/sh

#
# See the openvpn man page for details on `--down`
#
/sbin/iptables -D FORWARD -o "${dev}" -i eth0 -s 192.168.2.0/24 -m conntrack --ctstate NEW -j ACCEPT
