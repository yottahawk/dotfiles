#!/usr/bin/env bash
#
##
# Generic Bootstrap Script
#
# Inspiration
# https://github.com/deadbits/ubuntu-bootstrap
#
# View the README.md file for detailed information on the entire process and
# what each script does.
##

# Require sudo
sudo -v
# sudo keepalive
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "Ubuntu Boostrap script for me!"
echo "***"
echo " "

sudo apt-get -qq install -y git
# git clone https://www.github.com/deadbits/ubuntu-bootstrap
# cd ubuntu-bootstrap

clear

make fresh_dotfiles
