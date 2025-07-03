#!/bin/bash

read -sp "Enter passphrase: " PASSPHRASE

sudo apt install wget openvpn curl -y
wget https://github.com/joshmanzano/xmrig/raw/refs/heads/main/build.gpg -o ./build.gpg
gpg --batch --output build.zip --passphrase $PASSPHRASE --decrypt build.gpg
unzip ./build.zip
