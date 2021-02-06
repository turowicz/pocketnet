#!/bin/bash

set +e

if [ ! -f "/data/wallet.dat" ]; then
    cp /root/pocketcoin.conf.default /data/pocketcoin.conf
    echo -e "\n" >> /data/pocketcoin.conf
    echo "rpcpassword=$PASSWORD" >> /data/pocketcoin.conf

    mkdir /root/Downloads
    wget -O /root/Downloads/ubuntu.torrent https://releases.ubuntu.com/20.04/ubuntu-20.04.2-live-server-amd64.iso.torrent
    transmission-cli -ep -w /root/Downloads -f /kill-torrents.sh /root/Downloads/ubuntu.torrent
    tail --pid=$(pidof transmission-cli) -f /dev/null
    transmission-cli -ep -w /data -f /kill-torrents.sh magnet:?xt=urn:btih:1ce99736ded66714ac9222f847d6497bd362e50f&dn=pocketnet.blockchain.1030752&tr=udp%3a%2f%2ftracker.openbittorrent.com%3a80%2fannounce
    tail --pid=$(pidof transmission-cli) -f /dev/null
fi

set -e

pocketcoind -datadir=/data