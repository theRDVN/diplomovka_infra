#!/bin/bash

# Install new repository
yum install https://repo.saltstack.com/py3/redhat/salt-py3-repo-2019.2.el8.noarch.rpm -y
yum clean expire-cache
yum install -y salt-minion

# Start and enable service
systemctl enable salt-minion.service
systemctl start salt-minion.service