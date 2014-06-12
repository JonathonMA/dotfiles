# Backgrounded rails development
# Run these three in a backgrounded screen/tmux
alias cgit='watch -n 90 git fetch'
alias cgits='find . -maxdepth 3 -name ".gitfetch" | sed -e "s/.gitfetch$//" | xargs gitfetcher'
alias smartman='rerun -d .git -p CURRENT_BRANCH foreman start'
alias smartzeus='TERM=xterm rerun -d .git -p CURRENT_BRANCH zeus start'

# Use this to manually restart the backgrounded workers
function restartforeman ()
{
  if [ -f ".git/CURRENT_BRANCH" ]; then
    touch .git/CURRENT_BRANCH
  else
    echo "can't find CURRENT_BRANCH (probably not in git root)"
  fi
}

alias rf=restartforeman
