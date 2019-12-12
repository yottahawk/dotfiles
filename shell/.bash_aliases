alias chrome="google-chrome"
alias reboot="shutdown -r 0"
alias logout="gnome-session-quit --force"
alias path='echo "---FIRST---:$PATH:---LAST---" | tr : "\n"'
alias printenv="printenv | sort"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Good Article :
# https://dev.to/victoria/how-to-do-twice-as-much-with-half-the-keystrokes-using-bashrc-4o9k

# Always copy contents of directories (r)ecursively and explain (v) what was done
alias cp='cp -rv'
# Explain (v) what was done when moving a file
alias mv='mv -v'
# Remove recursively/directories(r) and force (f). Explain (v) what was done when moving a file
alias rm='rm -rfv'
# Explain (v) what was done when moving a file
alias mv='mv -v'
# Create any non-existent (p)arent directories and explain (v) what was done
alias mkdir='mkdir -pv'

# List contents with colors for file types
alias l='\ls --color=always \
             --group-directories-first'
# List contents with colors, (1) entry per line
alias ls='l --color=always \
            --group-directories-first \
            -1'
# List contents with colors, (A)lmost all hidden files (without . and ..), (1) entry per line
alias la='l --color=always \
            --group-directories-first \
            -A1'
# List contents with colors, (A)lmost all hidden files, use (l)ong listing format
alias ll='l --color=always \
            --group-directories-first \
            -Al'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
