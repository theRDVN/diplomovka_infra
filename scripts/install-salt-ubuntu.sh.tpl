#!/bin/bash
echo "Cloud init starting at `date`" > /tmp/init.log
sudo hostname ${hostname}
sudo echo "127.0.0.1 ${hostname}" >> /etc/hosts
echo "Set hostname to ${hostname}" >> /tmp/init.log
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common  -y
sudo apt-get update
sudo apt-get install docker-ce docker-compose -y
echo "Installed dependencies" >> /tmp/init.log
sudo curl -fsSL -o /usr/share/keyrings/salt-archive-keyring.gpg https://repo.saltproject.io/py3/ubuntu/18.04/amd64/latest/salt-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/salt-archive-keyring.gpg arch=amd64] https://repo.saltproject.io/py3/ubuntu/18.04/amd64/latest bionic main" | sudo tee /etc/apt/sources.list.d/salt.list
sudo apt-get update
sudo apt-get install salt-master salt-minion salt-api -y
echo "Installed saltstack services" >> /tmp/init.log
sudo cp /tmp/minion.conf /etc/salt/minion.d/minion.conf
sudo cp /tmp/grains /etc/salt/grains
sudo cp /tmp/master.conf /etc/salt/master.d/master.conf
sudo cp /tmp/roots.conf /etc/salt/master.d/roots.conf
sudo cp /tmp/gitfs.conf /etc/salt/master.d/gitfs.conf
sudo cp /tmp/gitfs_set.conf /etc/salt/master.d/gitfs_set.conf
# Create salt roots directories
sudo mkdir /opt/salt/common/artifacts -p
sudo mkdir /opt/salt/common/states -p
sudo mkdir /opt/salt/common/pillars -p
sudo mkdir /opt/salt/base/states -p
sudo mkdir /opt/salt/base/artifacts -p
sudo mkdir /opt/salt/base/pillars -p
sudo mkdir /opt/salt/states -p
sudo mkdir /opt/salt/formulas -p
cd /opt/salt/states
sudo git clone https://github.com/theRDVN/diplomovka_shared-all-salt-states.git
cd /opt/salt/formulas
sudo git clone https://github.com/theRDVN/diplomovka_salt-formula-saltmanage.git
sudo git clone https://github.com/theRDVN/diplomovka_salt-formula-linux.git
# Start and enable service
sudo apt-get install python3-pygit2 -y
sleep 5;
sudo systemctl enable salt-master.service
sudo systemctl restart salt-master.service
sleep 5;
sudo systemctl enable salt-api.service
sudo systemctl restart salt-api.service
sudo systemctl enable salt-minion.service
sudo systemctl restart salt-minion.service
echo "Cloud init ended at `date`" >> /tmp/init.log