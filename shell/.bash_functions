# -*-Shell-script-*-

# Limit length of ls output
function ls_limited () {
    if [ -z $1 ]; then
        max_lines=20
    else
        max_lines=$1
    fi
    linum=$(ls |\
                head -n $max_lines |\
                tee /dev/tty |\
                wc -l)
    # Print string if output is truncated....
    if test $linum -eq $max_lines; then
        echo -e "\e[4m...cont'd...\e[24m"
        # echo "(Output limited to $max_lines entries)"
    fi
}

# Show contents of the directory after changing to it
function cd () {
    case "$#" in
        0 )
            # Need this option to preserve cd-to-HOME behaviour. Don't 'ls' the HOME dir.
            builtin cd
            return $!
            ;;
        1 )
            # Cd and print directory. Limit output to $max_lines
            if [ ! -d "$1" ]; then
                # Catch options passed to cd
                builtin cd $1
                return
            fi
            builtin cd "$1"
            ls_limited 10
            ;;
        2 )
            builtin cd $@
            return $!
            ;;
    esac
}

### Functions to manage PATH cleanly ###
###################################################################

checkPATH () {
        case ":$PATH:" in
                *":$1:"*) return 1
                        ;;
        esac
        return 0;
}

# Prepend to $PATH
prependToPATH () {
        for a; do
                checkPATH $a
                if [ $? -eq 0 ]; then
                        PATH=$a:$PATH
                fi
        done
        export PATH
}

# Append to $PATH
appendToPATH () {
        for a; do
                checkPATH $a
                if [ $? -eq 0 ]; then
                        PATH=$PATH:$a
                fi
        done
        export PATH
}
