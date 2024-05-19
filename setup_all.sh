#!/bin/bash

sh ~/dotfiles/install_ubuntu.sh
sh ~/dotfiles/cp_bash.sh

TMUX_PATH=~/.tmux.conf
if test -f "$TMUX_PATH"; then
    mv ~/.tmux.conf ~/bashrc/backup_$(date +"%T")_tmux_conf
    echo "$TMUX_PATH exists, making backup"
fi
cp ~/bashrc/.tmux.conf  ~/.tmux.conf

sh ~/dotfiles/install_vim.sh
sh ~/dotfiles/install_miniconda.sh
