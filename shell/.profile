# Add user-binaries dir to path (Required for python packages installed with --user)
export PATH="$HOME/.local/bin:$PATH"

# Rust development
# export PATH="$PATH:$HOME/.cargo/bin"
# export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

# Quartus 18.1 Lite
export QUARTUS_ROOTDIR=/opt/intelFPGA_lite/18.1/quartus
export SOPC_KIT_NIOS2=/opt/intelFPGA_lite/18.1/nios2eds
export PATH="$PATH:/opt/intelFPGA_lite/18.1/nios2eds/bin/gnu/H-x86_64-pc-linux-gnu/bin"
export PATH="$PATH:/opt/intelFPGA_lite/18.1/nios2eds/sdk2/bin"
export PATH="$PATH:/opt/intelFPGA_lite/18.1/nios2eds/bin"
export PATH="$PATH:/opt/intelFPGA_lite/18.1/quartus/bin"
export PATH="$PATH:/opt/intelFPGA_lite/18.1/quartus/sopc_builder/bin"

# https://virtualenvwrapper.readthedocs.io/en/latest/install.html
FILE=/usr/local/bin/virtualenvwrapper.sh
if test -f "$FILE"; then
    # Virtualenvwrapper env-vars can be set for the login process once
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Projects
    export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
    export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
fi

# The script '.dotfiles/set_kbd' sets up the keyboard layouts for whichever system I am working on.
# For some reason, simply sourcing the script does not work, as the setxkbmap command is, on Ubuntu 19.04, overridden at some point later in the login process.
# I have spent way too long trying to fix this, and while I don't like the sleep-method, it certainly works. TBC
/bin/bash -c "sleep 3 && source ~/.dotfiles/set_kbd" &>/dev/null &
