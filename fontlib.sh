# fontlib.sh -- Install fonts from github
#   requires aria2c to orchestrate downloading missing files to where they should be
set -euo pipefail

if ! command -v aria2c >/dev/null; then
  echo "aria2c not found; not managing fonts"
  exit 0
fi

ARIAFILE="$(mktemp)"
trap 'rm -rf -- "$ARIAFILE"' EXIT

deploy() {
  github="$1" && shift
  sha="$1" && shift
  target="$1" && shift

  for file in "$@"; do
    filename="$(basename "$file")"
    if [ -f "$target/$filename" ]; then
      :
    else
      >> "$ARIAFILE" printf "https://raw.githubusercontent.com/%s/%s%s\n  dir=%s\n  out=%s\n" "$github" "$sha" "$file" "$target" "$filename"
    fi
  done
}

deploy_font() {
  github="$1" && shift
  sha="$1" && shift

  base="$(basename "$github")"
  target="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/${base}"

  deploy "$github" "$sha" "$target" "$@"
}

deploy_fontconfig() {
  github="$1" && shift
  sha="$1" && shift

  target="${XDG_CONFIG_HOME:-$HOME/.config}/fontconfig/conf.d"

  deploy "$github" "$sha" "$target" "$@"
}

do_deploy() {
  if [ -s "$ARIAFILE" ]; then
    aria2c --auto-file-renaming=false -j16 -i "$ARIAFILE"
  fi
}
