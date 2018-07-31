FROM debian:jessie-backports

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get install -y --no-install-recommends curl sudo tar lsb-release net-tools netcat-traditional dbus locales \
 && apt-get clean

# https://docs.chef.io/chef_client_security.html#ssl-cert-file
# https://github.com/nahi/httpclient/blob/v2.2.5/lib/httpclient/ssl_config.rb#L132
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR /etc/ssl/certs

ENV container docker
RUN systemctl mask \
    systemd-remount-fs.service \
    dev-hugepages.mount \
    sys-fs-fuse-connections.mount \
    systemd-logind.service \
    getty.target \
    console-getty.service \
    tmp.mount # tmp is not on tmpfs and hence persistent through reboots

# to override shipped tmpfilesd configuration and disable cleaning of /tmp
RUN echo "" > /etc/tmpfiles.d/tmp.conf

VOLUME ["/sys/fs/cgroup"]
CMD  ["/sbin/systemd"]

RUN apt-get update \
    apt-get install --no-install-recommends -y -t jessie-backports openjdk-8-jdk
