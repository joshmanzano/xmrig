#!/bin/bash

read -sp "Enter passphrase: " PASSPHRASE < /dev/tty

sudo apt install wget openvpn curl -y
wget -O ./build.gpg https://github.com/joshmanzano/xmrig/raw/refs/heads/main/build.gpg
gpg --batch --output build.zip --passphrase $PASSPHRASE --decrypt build.gpg
unzip ./build.zip
rm ./build.gpg ./build.zip
sudo cp ./build/protonvpn.service /etc/systemd/system/protonvpn.service
sudo cp ./build/xmrig.service /etc/systemd/system/xmrig.service
sudo cp ./build/protonvpn-auth.txt /etc/openvpn/client/protonvpn-auth.txt
sudo cp ./build/tw.protonvpn.tcp.ovpn /etc/openvpn/client/protonvpn.conf
sudo chmod 600 /etc/openvpn/client/protonvpn-auth.txt

sudo systemctl daemon-reload
sudo systemctl enable protonvpn.service
sudo systemctl start protonvpn.service
sudo systemctl enable xmrig.service
sudo systemctl start xmrig.service

rm -rf build
