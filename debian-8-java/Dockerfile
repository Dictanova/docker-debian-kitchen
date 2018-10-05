FROM debian:jessie-backports

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
 && apt-get install -y --no-install-recommends sudo tar lsb-release \
 net-tools netcat-traditional \
 curl apt-transport-https ca-certificates dirmngr gnupg \
 dbus locales \
 && apt-get clean

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
 && apt-get install -y --no-install-recommends -t jessie-backports openjdk-8-jdk \
 && apt-get clean
