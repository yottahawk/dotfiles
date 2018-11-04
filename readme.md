Dotfiles
========

Description
-----
A repository to VC my dotfiles, and provide scripts to bootstrap and apply them to a new development system.
*Currently only for Ubuntu*

Usage
-----
Run the following command on the box you wish to setup:  
`bash <(curl -sL https://raw.githubusercontent.com/yottahawk/dotfiles/develop/bootstrap.sh)`
  
This script will first install Git in order to clone this repository, prompt you for your sudo password that is used throughout the rest of the installation, and then proceed with each module.

Functionality
-----
- Pull the repository, and then create the symbolic links [using GNU stow](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/).
