#! /bin/bash

hostname ${hostname}
echo "127.0.0.1 ${hostname}" >> /etc/hosts

ufw allow 80
ufw allow 443

apt-get install apt-transport-https ca-certificates curl software-properties-common  -y
apt-get update
apt-get install docker-ce  -y
apt-get install python-pip -y
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh -P

echo "master: ${masterIP}" > /etc/salt/minion.d/minion.conf
echo "id: ${minionId}" >> /etc/salt/minion.d/minion.conf
echo "master_port: 4506" >> /etc/salt/minion.d/minion.conf
echo "publish_port: 4505" >> /etc/salt/minion.d/minion.conf
echo "saltenv: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "state_top_saltenv: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "default_top: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "test: False" >> /etc/salt/minion.d/minion.conf

# Start and enable service
systemctl enable salt-minion.service
systemctl restart salt-minion.service