#!/bin/bash

BASH_PATH=~/.bashrc
if test -f "$BASH_PATH"; then
    # if bashrc exists copy the bashrc to a backup, then link
    mv ~/.bashrc ~/dotfiles/backup_$(date +"%T")_bashrc
    echo "$BASH_PATH exists, making backup"
fi
cp ~/dotfiles/.bashrc  ~/.bashrc
