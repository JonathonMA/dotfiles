if has_command tinty; then
  apply_tinty_theme_if_changed() {
    declare current_theme
    read -r current_theme < "${XDG_DATA_HOME:-$HOME/.local/share}/tinted-theming/tinty/current_scheme"
    if [[ "${TINTY_THEME}" != "$current_theme" ]]; then
      tinty init
      TINTY_THEME="$current_theme"
    fi
  }
  export apply_tinty_theme_if_changed
  precmd_functions+=(apply_tinty_theme_if_changed)
fi
