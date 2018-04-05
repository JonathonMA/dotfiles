if command -v lessopen.sh >/dev/null; then
  export LESSOPEN="|$(which lessopen.sh) %s"
fi
