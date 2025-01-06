if has_command fzf; then
  eval "$(fzf --bash)"

  if has_command rg; then
    export FZF_DEFAULT_COMMAND="rg --files --hidden --smart-case --glob '!.git/*'"
  fi
fi
