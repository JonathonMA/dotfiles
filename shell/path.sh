function prepend_path() {
  if [ -d "$1" ]; then
    PATH="$1:$PATH"
  fi
}
function append_path() {
  if [ -d "$1" ]; then
    PATH="$PATH:$1"
  fi
}

PATH=$(getconf PATH)

prepend_path '/usr/sbin'
prepend_path '/sbin'
prepend_path '/usr/local/bin'
prepend_path '/usr/local/sbin'
append_path '/opt/X11/bin'
append_path '/usr/games'
append_path "$HOME/.local/bin"

prepend_path '/usr/local/opt/coreutils/libexec/gnubin'
# MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

if [ -f "$HOME/.bashrc.local.path" ]; then
  source "$HOME/.bashrc.local.path"
fi

unset prepend_path
unset append_path
