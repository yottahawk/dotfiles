# set -x

files=$(find . -name ".[^.]*")
# echo $files

for f in $files; do
    # echo ~/$(basename $f)
    rm -f ~/$f
done

