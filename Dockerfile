FROM ubuntu:focal

EXPOSE 51413
EXPOSE 58080

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

# Bootstrap
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install vim libqt5gui5 libboost-all-dev libevent-dev libzmq3-dev ufw transmission-cli wget && \
# Clean up
    ldconfig && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

# Install Pocket
ADD https://github.com/pocketnetteam/pocketnet.core/releases/download/v0.18.18/pocketnetcore_0.18.18_ubuntu_20.04_x64_setup.deb pocket.deb
RUN dpkg -i pocket.deb && apt install -f && rm pocket.deb

# Add scripts
ADD src/entrypoint.sh /entrypoint.sh
ADD src/kill-torrents.sh /entrypoint.sh
ADD src/pocketcoin.conf /root/.pocketcoin/pocketcoin.conf

# Set scripts attributes
RUN chmod +x /entrypoint.sh
RUN chmod +x /kill-torrents.sh

ENTRYPOINT /entrypoint.sh