#!/usr/bin/env bash

# Call GNU Stow only on directories in the .dotfile repo
for d in `ls -d */`;
do
    ( stow -D $d )
done
