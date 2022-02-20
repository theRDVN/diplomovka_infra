#!/bin/bash
sudo apt-get update
sudo apt-get install -y curl
wget -qO - https://www.mongodb.org/static/pgp/server-4.0.asc | sudo apt-key add -
sudo sh -c "cat <<EOT > /etc/apt/sources.list.d/mongodb-org-4.0.list
deb http://repo.mongodb.org/apt/ubuntu $(lsb_release -c | awk '{print $2}')/mongodb-org/4.0 multiverse
EOT"
sudo apt-get update
curl -1sLf "https://keys.openpgp.org/vks/v1/by-fingerprint/0A9AF2115F4687BD29803A206B73A36E6026DFCA" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/com.rabbitmq.team.gpg > /dev/null
curl -1sLf "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xf77f1eda57ebb1cc" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg > /dev/null
curl -1sLf "https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey" | sudo gpg --dearmor | sudo tee /usr/share/keyrings/io.packagecloud.rabbitmq.gpg > /dev/null
sudo tee /etc/apt/sources.list.d/rabbitmq.list <<EOF
deb [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu bionic main
deb-src [signed-by=/usr/share/keyrings/net.launchpad.ppa.rabbitmq.erlang.gpg] http://ppa.launchpad.net/rabbitmq/rabbitmq-erlang/ubuntu bionic main
deb [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ bionic main
deb-src [signed-by=/usr/share/keyrings/io.packagecloud.rabbitmq.gpg] https://packagecloud.io/rabbitmq/rabbitmq-server/ubuntu/ bionic main
EOF
sudo apt-get update
sudo apt-get install -y crudini
sudo apt-get install -y mongodb-org
sudo apt-get install -y erlang-base \
                      erlang-asn1 erlang-crypto erlang-eldap erlang-ftp erlang-inets \
                      erlang-mnesia erlang-os-mon erlang-parsetools erlang-public-key \
                      erlang-runtime-tools erlang-snmp erlang-ssl \
                      erlang-syntax-tools erlang-tftp erlang-tools erlang-xmerl
sudo apt-get install rabbitmq-server -y --fix-missing
sudo apt-get install -y redis-server
sudo systemctl enable mongod
sudo systemctl start mongod
curl -s https://packagecloud.io/install/repositories/StackStorm/stable/script.deb.sh | sudo bash
sudo apt-get install -y st2
DATASTORE_ENCRYPTION_KEYS_DIRECTORY="/etc/st2/keys"
DATASTORE_ENCRYPTION_KEY_PATH="${DATASTORE_ENCRYPTION_KEYS_DIRECTORY}/datastore_key.json"
sudo mkdir -p ${DATASTORE_ENCRYPTION_KEYS_DIRECTORY}
sudo st2-generate-symmetric-crypto-key --key-path ${DATASTORE_ENCRYPTION_KEY_PATH}
sudo chgrp st2 ${DATASTORE_ENCRYPTION_KEYS_DIRECTORY}
sudo chmod o-r ${DATASTORE_ENCRYPTION_KEYS_DIRECTORY}
sudo chgrp st2 ${DATASTORE_ENCRYPTION_KEY_PATH}
sudo chmod o-r ${DATASTORE_ENCRYPTION_KEY_PATH}
sudo crudini --set /etc/st2/st2.conf keyvalue encryption_key_path ${DATASTORE_ENCRYPTION_KEY_PATH}
sudo st2ctl restart-component st2api
sudo useradd stanley
sudo mkdir -p /home/stanley/.ssh
sudo chmod 0700 /home/stanley/.ssh
sudo ssh-keygen -f /home/stanley/.ssh/stanley_rsa -P ""
sudo sh -c 'cat /home/stanley/.ssh/stanley_rsa.pub >> /home/stanley/.ssh/authorized_keys'
sudo chown -R stanley:stanley /home/stanley/.ssh
sudo sh -c 'echo "stanley    ALL=(ALL)       NOPASSWD: SETENV: ALL" >> /etc/sudoers.d/st2'
sudo chmod 0440 /etc/sudoers.d/st2
sudo sed -i -r "s/^Defaults\s+\+?requiretty/# Defaults +requiretty/g" /etc/sudoers
sudo st2ctl start
sudo st2ctl reload
sudo apt-get install -y apache2-utils
echo '12345' | sudo htpasswd -i /etc/st2/htpasswd st2admin
sudo st2ctl restart-component st2api
sudo apt-get install -y st2web nginx
sudo mkdir -p /etc/ssl/st2
sudo openssl req -x509 -newkey rsa:2048 -keyout /etc/ssl/st2/st2.key -out /etc/ssl/st2/st2.crt \
-days 730 -nodes -subj "/C=SK/ST=SK/L=Piestany/O=StackStorm/OU=Information \
Technology/CN=$(hostname)"
sudo rm /etc/nginx/conf.d/default.conf
sudo rm -f /etc/nginx/sites-enabled/default
sudo cp /usr/share/doc/st2/conf/nginx/st2.conf /etc/nginx/conf.d/
sudo service nginx restart
sudo apt install python-pip -y
sudo st2 pack install salt https://github.com/theRDVN/diplomovka_ops_st2_pack.git