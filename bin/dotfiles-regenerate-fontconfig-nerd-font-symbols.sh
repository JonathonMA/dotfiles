#!/bin/bash

set -euo pipefail

tmpfile="$(mktemp fontconfig.XXX.conf)"
trap '{ rm -rf "${tmpfile?}"; }' EXIT

PREFER="$(fc-scan ~/.local/share/fonts/nerd-fonts/SymbolsNerdFontMono-Regular.ttf --format='%{family}')"

fonts() {
  echo monospace
  fc-list :mono --format '%{family}\n' | tr ',' '\n' | sort | uniq
}

jq_script() {
  cat <<- JQ
{
  "+p_xml": "version=\"1.0\"",
  "+directive": "DOCTYPE fontconfig SYSTEM \"fonts.dtd\"",
  fontconfig: {
    alias: \$fonts | map({family: ., prefer: {family: \$prefer}})
  },
}
JQ
}

exec jq \
  -n \
  --arg prefer "$PREFER" \
  --slurpfile fonts <(fonts | jq -R) \
  --from-file <(jq_script) |\
  yq -o=xml > "$tmpfile"
  mv -v "$tmpfile" "${FRESH_LOCAL}/xdg/config/fontconfig/conf.d/10-nerd-font-symbols.conf"
