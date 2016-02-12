FROM debian:wheezy
MAINTAINER Damien Raude-Morvan "drazzib@drazzib.com"

RUN apt-get update && apt-get install -y curl sudo tar && apt-get clean

RUN curl -L https://www.opscode.com/chef/install.sh | bash -s -- -v 12.5.1

RUN GEM_HOME="/tmp/verifier/gems" \
    GEM_PATH="/tmp/verifier/gems" \
    GEM_CACHE="/tmp/verifier/gems/cache" \
    /opt/chef/embedded/bin/gem install --no-rdoc --no-ri --bindir /tmp/verifier/bin \
    thor busser busser-serverspec serverspec bundler

# https://docs.chef.io/chef_client_security.html#ssl-cert-file
# https://github.com/nahi/httpclient/blob/v2.2.5/lib/httpclient/ssl_config.rb#L132
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt
ENV SSL_CERT_DIR /etc/ssl/certs

CMD  ["/sbin/init"]