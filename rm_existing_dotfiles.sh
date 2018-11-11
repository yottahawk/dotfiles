# set -x

# find all dotfiles in the ~ directory
files=$(find ~ -maxdepth 1 -type f -name ".[^.]*")

# unconditionally delete them all
#TODO : does this matter for dotfiles that are already present, but aren't then symlinked?
for f in $files; do
    rm -f $f
done

