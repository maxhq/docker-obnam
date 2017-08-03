## -*- docker-image-name: "maxhq/obnam" -*-

# base version shamelessly copied from https://github.com/vdemeester/dockerfiles

FROM jgoerzen/debian-base-minimal:stretch

# Install obnam
RUN apt-get update && \
    apt-get -q -y install ssh && \
    apt-get -q -y install obnam=1.21-1 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Let's define some convention folders
RUN mkdir -p /source /dest

# Add a user with uid 1000
RUN adduser --shell /bin/bash --uid 1000 --disabled-password --gecos "" obnam && \
    mkdir -p /home/obnam/run && \
    chown -R obnam /home/obnam/run

USER obnam

# Define default behavior
COPY obnam-wrapper /usr/bin/
ENTRYPOINT ["/usr/bin/obnam-wrapper"]
# No arguments by default :)
CMD [""]
