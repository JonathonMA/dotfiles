hook_if_defined() {
  func="$1"
  if type $func >/dev/null 2>&1; then
    precmd_functions+=($func)
  fi
}

hook_if_defined _bash_history_sync
hook_if_defined chnode_auto
hook_if_defined chruby_auto
# NOTE: bug if direnv fiddles the path *after* ch* and then cd out
# /ruby-version-dir/envrc-dir/ruby-version-dir
hook_if_defined _direnv_hook
