#!/usr/bin/env bash

set -eux

apt update
apt install -y --fix-broken git curl python3 python3-pip python3-venv libgconf-2-4
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
dpkg --install vscode.deb
code --install-extension ms-python.python
python3 -m pip install --upgrade pip pylint
