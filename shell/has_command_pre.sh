has_command() {
  local cmd="$1"

  command -v "$cmd"  >/dev/null
}

