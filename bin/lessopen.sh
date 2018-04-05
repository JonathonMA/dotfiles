#!/bin/sh

  # WHAT IS THIS
  # TODO: xdg
  # tmpfile=`mktemp "${TMPDIR-/tmp}/less.XXXXXX"`
  # "$@" "$file" > "$tmpfile"
  # echo "$tmpfile"
  # exit 0

filter() {
  file="$1"
  shift
  "$@" "$file"
}

case "$1" in
  *.md)
    markdown-cli "$1" --color
  ;;
esac
