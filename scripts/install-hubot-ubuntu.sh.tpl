#!/bin/bash
curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
sudo apt install nodejs
sudo su -
sudo su - stanley
sudo mkdir marvin-bot
cd marvin-bot
sudo npm install -g yo generator-hubot
sudo npm install -g hubot-stackstorm
yo hubot


ST2_AUTH_URL='130.211.109.194/auth' ST2_AUTH_USERNAME=stanley ST2_AUTH_PASSWORD='12345' HUBOT_SLACK_TOKEN=xoxb-3117155515542-3121123337157-TIvIrofS965mIsEfN2LraPDV ST2_ROUTE=diplomovka-notify PORT=8181 bin/hubot --name "marvin" -a slack --alias !