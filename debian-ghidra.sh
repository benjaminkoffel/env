#!/usr/bin/env bash

set -eux

sudo echo "deb http://ftp.us.debian.org/debian/ stretch-backports main" >> /etc/apt/sources.list
sudo apt update
sudo apt -y --fix-broken install build-essential module-assistant openjdk-11-jdk
sudo m-a prepare
wget https://ghidra-sre.org/ghidra_9.0.2_PUBLIC_20190403.zip
unzip ghidra_9.0.2_PUBLIC_20190403.zip
