# -*-Shell-script-*-

# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Detect Platform
if [ -n "${COMSPEC}" ]; then
    _IS_WINDOWS=1
    if [ -n "$(which cygpath 2>/dev/null)" ]; then
        _IS_CYGWIN=1
    fi
else
    _IS_LINUX=1
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth
# append to the history file, don't overwrite it
shopt -s histappend
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar
# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
TERM=xterm-256color
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls
# Export the LS_COLORS variable, used by ls and the --color argument in GNU applications
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi
# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# source user-defined functions
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi

################################################################################

if [[ -v _IS_CYGWIN ]]; then
    # Windows-Only here

    # This command helps to run shell scripts on Windows using cygwin bash.
    # The "igncr" option makes bash ignore the CR characters, part of DOS line endings
    # https://stackoverflow.com/questions/14598753/running-bash-script-in-cygwin-on-windows-7
    export SHELLOPTS
    set -o igncr
fi


if [[ -v _IS_LINUX ]]; then
    # Linux-Only here

    # The script '.dotfiles/set_kbd' sets up the keyboard layouts for whichever system I am working on.
    . ~/.dotfiles/set_kbd &>/dev/null

    ### PYTHON ###
    ##############################################################################

    # Add dir containing user-binaries to path (Required for python packages installed with --user)
    prependToPATH $HOME/.local/bin
    # Python/Pip https cert-store access on Ubuntu
    export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"

    # https://virtualenvwrapper.readthedocs.io/en/latest/install.html
    FILE=/usr/local/bin/virtualenvwrapper.sh
    if [[ -f "$FILE" ]]; then
        export WORKON_HOME=$HOME/.virtualenvs
        export PROJECT_HOME=$HOME/Projects
        export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
        export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
        # This script needs to be re-sourced upon each new shell creation
        . /usr/local/bin/virtualenvwrapper.sh
    fi

    # https://github.com/pyenv/pyenv
    if [[ -v $PYENV_ROOT ]]; then
        echo "True!"
        export PYENV_ROOT=$HOME/.pyenv
        prependToPATH $PYENV_ROOT/bin
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
    fi

    ### RUST ###
    ##############################################################################

    # Rust development
    prependToPATH $HOME/.cargo/bin
    export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

fi
