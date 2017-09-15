#!/bin/bash
# ---------------
#
# Install Cowrie
# https://github.com/micheloosterhof/cowrie/blob/master/INSTALL.md
#
#----------------

# remove old directories to do a clean install
if [ -d "cowrie" ]; then
  echo "Removing old cowrie directory" >>~/SETUP-RUN.TXT
  sudo rm -rf cowrie
fi
#install dependencies
sudo apt-get install -y git 
sudo apt-get install -y python-dev 
sudo apt-get install -y python-openssl
sudo apt-get install -y openssh-server
sudo apt-get install -y python-pyasn1 
sudo apt-get install -y python-twisted 
sudo apt-get install -y authbind

#change default port to Port 8742(to be tested with the pi)
#sed -i '/^Port/c\Port 8742' /etc/ssh/sshd_config

git clone https://github.com/LTW-GCR-CSOC/cowrie.git
cd cowrie
virtualenv cowrie-env
source cowrie-env/bin/activate
export PYTHONPATH=/home/cowrie/cowrie
bin/cowrie start
sudo iptables -t nat -A PREROUTING -p tcp --dport 22 -j REDIRECT --to-port 2222
apt-get install authbind
touch /etc/authbind/byport/22
chown cowrie:cowrie /etc/authbind/byport/22
chmod 770 /etc/authbind/byport/22
