#!/usr/bin/bash
echo "Cloud init starting at `date`" > /tmp/init.log
sudo hostname ${hostname}
sudo echo "127.0.0.1 ${hostname}" >> /etc/hosts
echo "Set hostname to ${hostname}" >> /tmp/init.log
sudo rpm --import https://repo.saltproject.io/py3/redhat/${major_release}/x86_64/latest/SALTSTACK-GPG-KEY.pub >> /tmp/init.log
curl -fsSL https://repo.saltproject.io/py3/redhat/${major_release}/x86_64/latest.repo | sudo tee /etc/yum.repos.d/salt.repo
sudo yum clean expire-cache
yum install -y salt-minion telnet docker docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
echo "Installed saltstack services" >> /tmp/init.log
echo "Installed docker & docker-compose services" >> /tmp/init.log
sudo cp /tmp/minion.conf /etc/salt/minion.d/minion.conf
sudo cp /tmp/grains /etc/salt/grains
sudo systemctl enable salt-minion.service
sudo systemctl restart salt-minion.service
sudo systemctl start docker
echo "Cloud init ended at `date`" >> /tmp/init.log