#!/bin/sh

file="$1"

[ -z "$file" ] && echo "Usage: `basename $0` <filename>" && exit 1

git commit --fixup `git log -n 1 --pretty=format:%H -- "$file"` "$file"
