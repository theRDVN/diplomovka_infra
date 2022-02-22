#!/bin/bash
sudo apt-get update
sudo apt-get install -y curl
bash <(curl -sSL https://stackstorm.com/packages/install.sh) --user=st2admin --password=12345
sudo apt install python-pip -y