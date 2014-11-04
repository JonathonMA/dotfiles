#!/bin/bash

brew_packages() {
  # TODO: this is where we'll map from debian package names to brew package names :)
  cat packages.list
}

########### FROM thoughtbot's laptop/mac ##########
brew_expand_alias() {
  brew info "$1" 2>/dev/null | head -1 | awk '{gsub(/:/, ""); print $1}'
}

brew_install_or_upgrade() {
  if brew_is_installed "$1"; then
    if brew_is_upgradable "$1"; then
      brew upgrade "$@"
    fi
  else
    brew install "$@"
  fi
}

brew_is_installed() {
  local name="$(brew_expand_alias "$1")"

  brew list -1 | grep -Fqx "$name"
}

brew_is_upgradable() {
  local name="$(brew_expand_alias "$1")"

  brew outdated --quiet "$name" >/dev/null
  [[ $? -ne 0 ]]
}
########### FROM thoughtbot's laptop/mac ##########

brew update
for package in $(brew_packages); do
  brew_install_or_upgrade $package
done

# brew unlink openssl && brew link openssl --force
