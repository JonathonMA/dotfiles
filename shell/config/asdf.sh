if [ -d ~/.local/share/asdf ]; then
  export ASDF_DATA_DIR=~/.local/share/asdf
  export ASDF_CONFIG_FILE=~/.config/asdf

  source "$ASDF_DATA_DIR"/asdf.sh
  source "$ASDF_DATA_DIR"/completions/asdf.bash
fi
