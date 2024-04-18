#!/bin/bash

set -euo pipefail

tmpfile="$(mktemp fontconfig.XXX.conf)"
trap '{ rm -rf "${tmpfile?}"; }' EXIT

PREFER="$(fc-scan ~/.local/share/fonts/nerd-fonts/SymbolsNerdFontMono-Regular.ttf --format='%{family}')"

fonts() {
  # fallback
  echo monospace
  # NOTE: family is potentially a multi-valued element, and we treat each as a separate font for <alias> purposes
  fc-list :mono --format '%{[]family{%{family}\n}}' | sort -u
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
  mv -v "$tmpfile" "${FRESH_LOCAL}/config/fontconfig/conf.d/10-nerd-font-symbols.conf"
