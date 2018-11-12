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

sudo apt-get update -y && sudo apt-get upgrade -y
# Useful requirements to install right now...
sudo apt-get -qq install -y git curl xterm whiptail make stow

#############################################################################################
# Next, ask the user what they actually want to do regarding the bootstrapping process..... #

# Title of script set
TITLE="Bootsrapping and dotfile setup"

# Main
function main {
	# Draw window
	MAIN=$(eval `resize` && whiptail \
		--notags \
		--title "$TITLE" \
		--menu "\nWhat would you like to do?" \
		--cancel-button "Quit" \
		$LINES $COLUMNS $(( $LINES - 12 )) \
		'fresh_install'         'Full bootstrap for new system (may wipe existing settings)' \
		'dotfiles'              'Delete all existing dotfiles, and symlink tracked ones' \
		'restow'                'Unstow and restow all user dotfiles' \
    'make_list_exit'        'Install another make target' \
		3>&1 1>&2 2>&3)
	# check exit status
	if [ $? = 0 ]; then
		# echo "Starting '$MAIN' function"
		$MAIN
	else
		# Quit
    echo "Exiting due to MAIN=$(eval ..) returning not equal to 0!"
    exit
	fi
}

# --clear
MAKETARGETS=$(make list)
function make_list_exit {
    clear
    echo " "
    echo "See the following list for all possible make-targets :"
    echo " "
    echo $MAKETARGETS
    echo " "
    echo "go nuts!"
    echo " "
    exit 99
}

# Quit
function quit {
	# Draw window
	if (whiptail --title "Quit" --yesno "Are you sure you want quit?" 8 56) then
		exit 99
	else
		main
	fi
}

function fresh_install {
    # Perform all of the config possible for the bootstrap process....
    ###
    sudo make -C ~/.dotfiles/ fresh_install
    ###
    return_to_menu
}

function dotfiles {
    # Install all user dotfiles by using the appropriate Makefile target....
    ###
    sudo make -C ~/.dotfiles/ fresh_install
    ###
    return_to_menu
}

function restow {
    # Install all user dotfiles by using the appropriate Makefile target....
    ###
    sudo make -C ~/.dotfiles/ restow
    ##
    return_to_menu
}

function return_to_menu {
    # Prompt user to return to menu?
    echo " "
    read -n 1 -s -r -p "Done! Press any key to continue..."
    echo " "
	  if (whiptail --title "Finished!" --yesno "Return to menu?" --defaultno 8 56) then
		   main
	     else
           exit 99
	  fi
}


while :
do
	main
done
