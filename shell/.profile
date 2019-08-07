if [ -n "${COMSPEC}" ]; then
    _IS_WINDOWS=1
    # PATH="/bin:/usr/bin:${PATH}"
fi
if [ "${_IS_WINDOWS}" = "1" ] && [ -n "$(which cygpath 2>/dev/null)" ]; then
    _IS_CYGWIN=1
fi

if [ "${_IS_CYGWIN}" = "1" ]; then
    # Windows-Only here
    echo "Windows-only init"

    # This command helps to run shell scripts on Windows using cygwin bash.
    # The "igncr" option makes bash ignore the CR characters, part of DOS line endings
    # https://stackoverflow.com/questions/14598753/running-bash-script-in-cygwin-on-windows-7
    export SHELLOPTS
    set -o igncr

else
    # Linux-Only here

    # Add user-binaries dir to path (Required for python packages installed with --user)
    export PATH="$HOME/.local/bin:$PATH"
    # Python/Pip https cert-store access on Ubuntu
    export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"

    # Rust development
    # export PATH="$PATH:$HOME/.cargo/bin"
    # export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

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
fi
