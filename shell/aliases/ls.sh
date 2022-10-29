# detect GNU ls
if ls --color -d . >/dev/null 2>&1; then
  alias ls='ls --color=auto'
fi

if has_command exa; then
  alias ll='exa -alF'
  alias la='exa -a'
  alias l='exa --icons -GF'
else
  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'
fi
