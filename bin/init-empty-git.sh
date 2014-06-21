#!/bin/sh

set -e

in_git_repo() {
  git rev-parse --git-dir >/dev/null 2>&1
}

main() {
  if in_git_repo; then
    echo "looks like you're already in a git repo, bailing"
    exit 1
  fi

  git init
  [ -f .gitignore ] && mv .gitignore .gitignore.bak
  touch .gitignore
  git add .gitignore
  git commit -m "empty"
  [ -f .gitignore.bak ] && mv .gitignore.bak .gitignore
  git tag root
}

main
