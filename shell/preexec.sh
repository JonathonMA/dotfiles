hook_if_defined() {
  func="$1"
  if type $func >/dev/null 2>&1; then
    precmd_functions+=($func)
  fi
}

hook_if_defined _bash_history_sync
hook_if_defined chnode_auto
hook_if_defined chruby_auto
hook_if_defined _direnv_hook
