#!/bin/bash

sudo add-apt-repository ppa:jonathonf/vim -y
sudo add-apt-repository ppa:neovim-ppa/unstable -y
sudo apt update

# update vim
sudo apt install vim -y

# install neovim
sudo apt install neovim -y

# install npm
curl -sL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt install nodejs -y


if [[ ! -f "~/.config/nvim/init.vim" ]]
then
    mkdir ~/.config/nvim
    touch ~/.config/nvim/init.vim
    bash -c 'echo "set runtimepath^=~/nvim_configuration" >> ~/.config/nvim/init.vim'
    bash -c 'echo "source ~/dotfiles/init.lua" >> ~/.config/nvim/init.vim'
fi
