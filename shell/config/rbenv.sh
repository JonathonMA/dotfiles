if [ -x ~/.rbenv/bin/rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
elif command -v rbenv >/dev/null; then
  # Note --no-rehash since rbenv rehash is like 300ms :(
  eval "$(rbenv init - --no-rehash)"

  # OS X only
  if grep -q BUNDLE_JOBS ~/.bundle/config; then
    :
  else
    number_of_cores=`sysctl -n hw.ncpu`
    bundle config --global jobs `expr $number_of_cores - 1`
  fi
fi
