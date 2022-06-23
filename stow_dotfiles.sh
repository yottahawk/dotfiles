#!/usr/bin/env bash

# Call GNU Stow only on directories in the .dotfile repo
cd ~/.dotfiles/
for d in `ls -d */`;
do
    ( stow $d -n)
done
