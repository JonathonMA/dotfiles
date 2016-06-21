if [ -s ~/.nvm/nvm.sh ] && ! type -t nvm >/dev/null; then
  export NVM_DIR=~/.nvm
  source ~/.nvm/nvm.sh
fi
