FROM        ubuntu:14.04.2
MAINTAINER  Love Nyberg "love.nyberg@lovemusic.se"
ENV REFRESHED_AT 2014-10-18

# Update the package repository and install applications
RUN apt-get update -qq && \
  apt-get upgrade -yqq && \
  apt-get -yqq install varnish && \
  apt-get -yqq clean

# Make our custom VCLs available on the container
ADD default.vcl /etc/varnish/default.vcl

ENV VARNISH_BACKEND_PORT 8080
ENV VARNISH_BACKEND_IP 172.17.0.1
ENV VARNISH_PORT 8080

# Expose port 80
EXPOSE 8080

# Expose volumes to be able to use data containers
VOLUME ["/var/lib/varnish", "/etc/varnish"]

ADD start.sh /start.sh
CMD ["/start.sh"]
