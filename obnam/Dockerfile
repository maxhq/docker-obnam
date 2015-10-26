## -*- docker-image-name: "maxhq/obnam" -*-

# base version shamelessly copied from https://github.com/vdemeester/dockerfiles

FROM debian:jessie

# Install obnam
RUN echo "deb http://http.debian.net/debian jessie-backports main" > /etc/apt/sources.list && \
    apt-get update && \
    apt-get -y install ssh && \
    apt-get -y -t jessie-backports install obnam && \
    apt-get clean

# Let's define some convention folders
RUN mkdir -p /source /dest

# Add a user with uid 1000
RUN adduser --shell /bin/bash --uid 1000 --disabled-password --gecos "" user && \
    mkdir -p /home/user/run && \
    chown -R user /home/user/run

USER user

# Define default behavior
COPY obnam-wrapper /usr/bin/
ENTRYPOINT ["/usr/bin/obnam-wrapper"]
# No arguments by default :)
CMD [""]
