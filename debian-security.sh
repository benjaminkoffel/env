#!/usr/bin/env bash

# UPGRADE
apt update
apt -y upgrade

# DEV TOOLS
apt -y --fix-broken install build-essential module-assistant git nmap dnsutils curl golang python-pip python3 python3-pip net-tools tor proxychains openvpn sshuttle libgconf-2-4

# VIRTUAL BOX ADDITIONS
m-a -q prepare
mount /media/cdrom
sh /media/cdrom/VBoxLinuxAdditions.run

# DOCKER
apt -y install apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt -y install docker-ce
service docker start

# BURP SUITE
wget https://portswigger.net/burp/releases/download?productid=100&version=1.7.23&type=jar -O /opt/burp.jar
chown root:root /opt/burp.jar
echo "java -jar -Xmx1024m /opt/burp.jar &" > /usr/local/bin/burp
chmod a+x /usr/local/bin/burp

# VSCODE
wget https://go.microsoft.com/fwlink/?LinkID=760868 -O vscode.deb
dpkg --install vscode.deb
rm vscode.deb

# TOR BROWSER
curl "https://pgp.mit.edu/pks/lookup?op=get&search=0x4E2C6E8793298290" -o - | gpg --import
#gpg --keyserver pool.sks-keyservers.net --recv-keys 0x4E2C6E8793298290
gpg --fingerprint 0x4E2C6E8793298290
wget https://www.torproject.org/dist/torbrowser/7.0.2/tor-browser-linux64-7.0.2_en-US.tar.xz.asc
wget https://www.torproject.org/dist/torbrowser/7.0.2/tor-browser-linux64-7.0.2_en-US.tar.xz
gpg --verify tor-browser-linux64-7.0.2_en-US.tar.xz.asc tor-browser-linux64-7.0.2_en-US.tar.xz
tar -xf tor-browser-linux64-7.0.2_en-US.tar.xz
mv tor-browser_en-US /opt
chmod a+x /opt/tor-browser_en-US
echo -e "cd /opt/tor-browser_en-US/\n./start-tor-browser.desktop" > /usr/local/bin/torbrowser
chmod a+x /usr/local/bin/torbrowser
rm tor-browser-linux64-7.0.2_en-US.tar.xz.asc
rm tor-browser-linux64-7.0.2_en-US.tar.xz

# METASPLOIT
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall

# AWS CLI
pip install --upgrade awscli
