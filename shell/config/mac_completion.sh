for file in \
  /usr/local/etc/bash_completion.d/git-completion.bash \
  /usr/local/etc/bash_completion.d/git-prompt.sh; do
  [ -f "$file" ] && source $file
done
