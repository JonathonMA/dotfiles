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

prepend_path '/usr/local/bin'
prepend_path '/usr/local/sbin'
append_path '/opt/X11/bin'

unset prepend_path
unset append_path
