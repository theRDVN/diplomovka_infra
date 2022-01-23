#!/bin/bash

echo "Cloud init starting at `date`" > /tmp/init.log
hostname ${hostname}
echo "127.0.0.1 ${hostname}" >> /etc/hosts

# Install new repository
rpm --import https://repo.saltproject.io/py3/redhat/8/x86_64/latest/SALTSTACK-GPG-KEY.pub >> /tmp/init.log
curl -fsSL https://repo.saltproject.io/py3/redhat/8/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo

sudo yum clean expire-cache
yum install -y salt-minion

echo "master: ${masterNode}" > /etc/salt/minion.d/minion.conf
echo "id: ${minionId}" >> /etc/salt/minion.d/minion.conf
echo "master_port: 4506" >> /etc/salt/minion.d/minion.conf
echo "publish_port: 4505" >> /etc/salt/minion.d/minion.conf
echo "saltenv: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "state_top_saltenv: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "default_top: ${minionEnv}" >> /etc/salt/minion.d/minion.conf
echo "test: False" >> /etc/salt/minion.d/minion.conf

# Start and enable service
systemctl enable salt-minion.service
systemctl start salt-minion.service