#!/bin/bash

# modified from
# https://gist.github.com/danijar/11b53beaccce601fe737cc98315d3dea

sudo -E apt-get update
sudo -E apt-get install -y \
    software-properties-common git curl tmux net-tools \
    silversearcher-ag ripgrep \
    # nvidia-driver-535 \
