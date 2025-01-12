if command -v starship > /dev/null; then
  eval "$(starship init bash)"
else
  if [[ -e /usr/lib/git-core/git-sh-prompt ]]; then
    . /usr/lib/git-core/git-sh-prompt
  fi

  function __git_in_repo() { __gitdir > /dev/null; }
  function __git_is_dirty() { git status --porcelain | grep -q .; }
  function __git_dirty() { __git_in_repo && __git_is_dirty && echo "$1"; }
  function __git_clean() { __git_in_repo && (__git_is_dirty || echo "$1"); }
  function __jobs_any() { jobs | grep -q . && echo "$1"; }

  export PS1_PWD_COLOR=36

  export PS1='$(__git_ps1 "\[\e[37m\](\[\e[0m\]")$(__git_dirty "\[\e[31m\]✗\[\e[0m\]")$(__git_clean "\[\e[32m\]✓\[\e[0m\]")$(__git_ps1 " \[\e[34m\]%s\[\e[0;37m\])\[\e[0m\] ")$(__jobs_any "\[\e[33m\]ꕚ \[\e[0m\]")\[\e[${PS1_PWD_COLOR}m\]\w\[\e[0;33m\]\$\[\e[0m\] '
fi
