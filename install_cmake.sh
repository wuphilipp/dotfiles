#!/bin/bash

# https://askubuntu.com/questions/355565/how-do-i-install-the-latest-version-of-cmake-from-the-command-line

sudo apt remove --purge --auto-remove cmake -y

sudo apt update && \
    sudo apt install -y software-properties-common lsb-release && \
    sudo apt clean all


wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null

sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main" -y

sudo apt update 
sudo apt install kitware-archive-keyring -y
sudo rm /etc/apt/trusted.gpg.d/kitware.gpg

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 6AF7F09730B3F0A4

sudo apt update
sudo apt install cmake -y
