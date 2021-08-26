# path functions from: https://stackoverflow.com/a/24522107
# The functions below operate on PATH-like variables whose fields are separated
# with ':'.
# Note: The *name* of the PATH-style variable must be passed in as the 1st
#       argument and that variable's value is modified *directly*.

# SYNOPSIS: path_prepend varName path
# Note: Forces path into the first position, if already present.
#       Duplicates are removed too, unless they're directly adjacent.
# EXAMPLE: path_prepend PATH /usr/local/bin
path_prepend() {
  local aux=":${!1}:"
  aux=${aux//:$2:/:}; aux=${aux#:}; aux=${aux%:}
  printf -v "$1" '%s' "${2}${aux:+:}${aux}"
}

# SYNOPSIS: path_append varName path
# Note: Forces path into the last position, if already present.
#       Duplicates are removed too, unless they're directly adjacent.
# EXAMPLE: path_append PATH /usr/local/bin
path_append() {
  local aux=":${!1}:"
  aux=${aux//:$2:/:}; aux=${aux#:}; aux=${aux%:}
  printf -v "$1" '%s' "${aux}${aux:+:}${2}"
}

# SYNOPSIS: path_remove varName path
# Note: Duplicates are removed too, unless they're directly adjacent.
# EXAMPLE: path_remove PATH /usr/local/bin
path_remove() {
  local aux=":${!1}:"
  aux=${aux//:$2:/:}; aux=${aux#:}; aux=${aux%:}
  printf -v "$1" '%s' "$aux"
}
