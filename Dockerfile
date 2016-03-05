FROM debian:wheezy
MAINTAINER Damien Raude-Morvan "drazzib@drazzib.com"

RUN apt-get update \
 && apt-get install -y curl sudo tar lsb-release net-tools netcat-traditional \
 && apt-get clean

# Don't clean /tmp !
RUN update-rc.d mountall-bootclean.sh disable \
 && update-rc.d mountnfs-bootclean.sh disable \
 && update-rc.d checkroot-bootclean.sh disable

# Install the Chef client
RUN curl -L https://www.opscode.com/chef/install.sh | bash -s -- -v 12.7.2

# Prepare the gem cache used by Kitchen and Busser
RUN GEM_HOME="/tmp/verifier/gems" \
    GEM_PATH="/tmp/verifier/gems" \
    GEM_CACHE="/tmp/verifier/gems/cache" \
    /opt/chef/embedded/bin/gem install --no-rdoc --no-ri \
    --no-format-executable -n /tmp/verifier/bin --no-user-install \
    busser

RUN GEM_HOME="/tmp/verifier/gems" \
    GEM_PATH="/tmp/verifier/gems" \
    GEM_CACHE="/tmp/verifier/gems/cache" \
    /opt/chef/embedded/bin/gem install --no-rdoc --no-ri \
    busser-serverspec serverspec bundler yarjuf

RUN useradd kitchen && chown -R kitchen:kitchen /tmp/verifier

# https://docs.chef.io/chef_client_security.html#ssl-cert-file
# https://github.com/nahi/httpclient/blob/v2.2.5/lib/httpclient/ssl_config.rb#L132
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR /etc/ssl/certs

CMD  ["/sbin/init"]
