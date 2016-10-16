if command -v direnv > /dev/null; then
  _direnv_hook() {
    local previous_exit_status=$?;
    eval "$(direnv export bash)";
    return $previous_exit_status;
  };
fi
