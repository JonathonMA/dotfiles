if ! has_command pbcopy; then
  alias pbcopy='xsel --clipboard --input'
fi

if ! has_command pbpaste; then
  alias pbpaste='xsel --clipboard --output'
fi
