# ENV

# export PATH="$PATH:$HOME/.cargo/bin"
# export PATH="$PATH:/opt/intelFPGA_lite/18.1/nios2eds"

# https://virtualenvwrapper.readthedocs.io/en/latest/install.html
FILE=/usr/local/bin/virtualenvwrapper.sh
if test -f "$FILE"; then
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Projects
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
    source /usr/local/bin/virtualenvwrapper.sh
fi

# The script '.dotfiles/set_kbd' sets up the keyboard layouts for whichever system I am working on.
# For some reason, simply sourcing the script does not work, as the setxkbmap command is, on Ubuntu 19.04, overridden at some point later in the login process.
# I have spent way too long trying to fix this, and while I don't like the sleep-method, it certainly works. TBC
/bin/bash -c "sleep 3 && source ~/.dotfiles/set_kbd" &>/dev/null &
