# openvpn-gateway

Minimal container that routes LAN traffic over an OpenVPN client connection - this is not for hosting an OpenVPN server. I was connecting to an OpenVPN server through my home router but losing about 80% of my normal bandwidth, turns out I was maxing out my router's physical capabilities with all that crypto work. Dusty old laptop running CoreOS with more horsepower to the rescue.

## Why?

Unlike the containers I found on docker hub, this one specifically does *not* have anything to do with configuring OpenVPN. This project exists for the sole purpose of gluing OpenVPN to an `iptables` command or two to route traffic through the VPN tunnel in a very small image (under 8MB). For hosting an OpenVPN server or just something more comprehensive and user-friendly search for `openvpn` on Docker hub. The following assumptions are made:

* You have or will configure OpenVPN through your own means
* Your docker host is already a functioning router; now you just want to route that existing traffic through OpenVPN
* You know how docker data volumes work and/or know how to use the `-v` option to `docker run`, and will pass in your OpenVPN configuration appropriately

## Building the image

1. Edit `on-up.sh` and `on-down.sh` and change `192.168.2.0/24` to match your local LAN network settings
2. (optional) Modify `Dockerfile` to bake your OpenVPN client configuration directly in to the image
3. Run `docker build -t my-vpn-gateway .`

## Running it

`docker run -d --net=host --cap-add=NET_ADMIN --device /dev/net/tun my-vpn-gateway <full path to ovpn conf>`

Remember to include appropriate `-v` and/or `--volumes-from` options to pass in your OpenVPN client configuration.

## Thank you

* to the creators/maintainers/contributors/community of docker and OpenVPN
* to Kyle Manna for his [`Dockerfile`](https://github.com/kylemanna/docker-openvpn/blob/master/Dockerfile) which I used as a template and by way of which I was introduced to Alpine Linux
* to a [frustrated Australian](https://support.hidemyass.com/hc/en-us/articles/202721486-Using-Linux-Virtual-Machine-instead-of-a-router-for-VPN) for documenting a nearly identical setup and providing exactly the `iptables` commands I needed
