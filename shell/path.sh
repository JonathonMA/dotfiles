# EXAMPLE: path_prepend PATH /usr/local/bin
# EXAMPLE: path_append PATH /usr/games

PATH=$(getconf PATH)

path_prepend PATH '/usr/sbin'
path_prepend PATH '/sbin'
path_prepend PATH '/usr/local/bin'
path_prepend PATH '/usr/local/sbin'
path_append PATH '/opt/X11/bin'
path_append PATH '/usr/games'
path_append PATH "$HOME/.local/bin"

if command -v brew >/dev/null; then
  path_prepend PATH "$(brew --prefix)/opt/coreutils/libexec/gnubin"
  path_prepend PATH "$(brew --prefix)/opt/findutils/libexec/gnubin"
  path_prepend PATH "$(brew --prefix)/opt/gnu-sed/libexec/gnubin"
fi

if [ -f "$HOME/.bashrc.local.path" ]; then
  source "$HOME/.bashrc.local.path"
fi

for dir in ~/src/*.com; do
  path_append CDPATH "$dir"
done
