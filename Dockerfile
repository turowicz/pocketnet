FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /workspace

# Installation
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install vim libqt5gui5 libboost-all-dev libevent-dev libzmq3-dev ufw transmission-cli wget && \
    # Clean up
    ldconfig && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ADD https://github.com/pocketnetteam/pocketnet.core/releases/download/v0.18.18/pocketnetcore_0.18.18_ubuntu_20.04_x64_setup.deb pocket.deb

RUN dpkg -i pocket.deb && apt install -f && rm pocket.deb

EXPOSE 51413
EXPOSE 58080

RUN touch /kill-torrents.sh && \
    chmod a+x /kill-torrents.sh && \
    echo "pkill -f transmission-cli" > /kill-torrents.sh

ADD pocketcoin.conf /root/.pocketcoin/pocketcoin.conf
ADD entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh
ENTRYPOINT /entrypoint.sh