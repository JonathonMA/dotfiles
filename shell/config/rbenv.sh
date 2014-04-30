if [ -x ~/.rbenv/bin/rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
elif command -v rbenv >/dev/null; then
  # Note --no-rehash since rbenv rehash is like 300ms :(
  eval "$(rbenv init - --no-rehash)"
fi
