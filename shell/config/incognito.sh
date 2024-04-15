INCOGNITO_MARKER="🕵️"
INCOGNITO_HISTORY_FILE="bash_history_incognito"
INCOGNITO_VAR_PREFIX="_IG_OLD"

_ig_pushvars() {
  for var in "$@"; do
    export ${INCOGNITO_VAR_PREFIX}_${var}="${!var}"
  done
}

_ig_popvars() {
  # TODO: how to indirect INCOGNITO_VAR_PREFIX here?
  for var in ${!_IG_OLD_@}; do
    export ${var/${INCOGNITO_VAR_PREFIX}_/}="${!var}"
    unset "$var"
  done
}

incognito_enter() {
  _ig_pushvars HISTFILE PS1 PWD PS1_PWD_COLOR

  export PS1_PWD_COLOR=35
  export HISTFILE="${XDG_CACHE_HOME:-${HOME}/.cache}/${INCOGNITO_HISTORY_FILE}"
  export PS1="$INCOGNITO_MARKER  $PS1"

  alias incognito=incognito_exit
}

incognito_exit() {
  local old_pwd_var="${INCOGNITO_VAR_PREFIX}_PWD"
  local old_pwd="${!old_pwd_var}"

  cd "$old_pwd"
  echo "$old_pwd"

  # NOTE: this will also reset PWD, which doesn't actually change the pwd (!), but we already effected that above
  _ig_popvars

  alias incognito=incognito_enter
}

alias incognito=incognito_enter
