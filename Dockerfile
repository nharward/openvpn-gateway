FROM alpine:edge
MAINTAINER Nathaniel Harward <nharward+openvpn-client@gmail.com>

ADD on-up.sh /usr/libexec/openvpn/on-up.sh

RUN chmod 700 /usr/libexec/openvpn/on-up.sh && \
    apk add --update-cache openvpn=2.3.10-r1 && \
    rm -rf /var/cache/apk/*

ENTRYPOINT ["/usr/sbin/openvpn", "--script-security", "2", "--up", "/usr/libexec/openvpn/on-up.sh", "--config"]
