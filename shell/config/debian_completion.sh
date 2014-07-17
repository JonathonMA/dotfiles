# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi

  __gitdir ()
  {
    if [ -z "${1-}" ]; then
      if [ -n "${__git_dir-}" ]; then
        echo "$__git_dir"
      elif [ -n "${GIT_DIR-}" ]; then
        test -d "${GIT_DIR-}" || return 1
        echo "$GIT_DIR"
      elif [ -d .git ]; then
        echo .git
      else
        git rev-parse --git-dir 2>/dev/null
      fi
    elif [ -d "$1/.git" ]; then
      echo "$1/.git"
    else
      echo "$1"
    fi
  }
fi
