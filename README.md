# openvpn-gateway

Minimal container that routes LAN traffic over an OpenVPN connection. I was using OpenVPN through my router but losing about 80% of my normal bandwidth. Turns out I was maxing out my router's physical capabilities. Dusty old laptop running CoreOS to the rescue.

## Why?

Unlike the containers I found on docker hub, this one specifically does *not* to have anything to do with configuring OpenVPN. The assumption is that this is, for whatever reason, better done elsewhere. This project exists for the purpose of gluing OpenVPN to the needed `iptables` commands to route others' traffic through the VPN tunnel in a very small image (under 8MB) - nothing more. It also assumes you can set up a data volume and/or use the `docker run` _-v_ option without assistance. For something more comprehensive and user-friendly, search for `openvpn` on Docker hub.

## Building it

1. Edit `on-up.sh` and change `192.168.2.0/24` to match your local LAN network settings
2. (optional) Modify `Dockerfile` to bake your OpenVPN configuration in to the image
3. Run `docker build -t my-vpn-gateway .`

## Running it

`docker run -d --net=host --cap-add=NET_ADMIN --device /dev/net/tun my-vpn-gateway <full path to ovpn conf>`

Not included are either `-v` or `--volumes-from` option(s) to pass in your separately-created OpenVPN configuration.

## Thank you

* to the creators/maintainers/contributors/community of docker and OpenVPN
* to Kyle Manna for his [`Dockerfile`](https://github.com/kylemanna/docker-openvpn/blob/master/Dockerfile) which I used as a template and by way of which I was introduced to Alpine Linux
* to a [frustrated Australian](https://support.hidemyass.com/hc/en-us/articles/202721486-Using-Linux-Virtual-Machine-instead-of-a-router-for-VPN) for documenting a nearly identical setup and providing exactly the `iptables` commands I needed
