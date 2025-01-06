# detect GNU ls
if ls --color -d . >/dev/null 2>&1; then
  alias ls='ls --color=auto'
fi

if has_command eza; then
  alias ll='eza -alF'
  alias la='eza -a'
  alias l='eza --icons -GF'
  alias l1='l -1'
  alias exa=eza
else
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi
