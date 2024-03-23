# fontlib.sh -- Install fonts from github
#   requires aria2c to orchestrate downloading missing files to where they should be
set -euo pipefail

if ! command -v aria2c >/dev/null; then
  echo "aria2c not found; not managing fonts"
  exit 0
fi

ARIAFILE="$(mktemp)"
trap 'rm -rf -- "$ARIAFILE"' EXIT

github_glob() {
  shopt -s globstar
  github="$1" && shift
  ref="$1" && shift

  url="$(printf "https://api.github.com/repos/%s/git/trees/%s?recursive=1" "$github" "$ref")"
  curl -s "$url" | jq -r '.tree | map(.path)[]' | while read i; do
    for glob in "$@"; do
      [[ $i == @($glob) ]] && echo "$i" && break || true
    done
  done
}

deploy() {
  github="$1" && shift
  ref="$1" && shift
  target="$1" && shift

  for file in "$@"; do
    filename="$(basename "$file")"
    if [ -f "$target/$filename" ]; then
      :
    else
      >> "$ARIAFILE" printf "https://raw.githubusercontent.com/%s/%s/%s\n  dir=%s\n  out=%s\n" "$github" "$ref" "$file" "$target" "$filename"
    fi
  done
}

deploy_font() {
  github="$1" && shift
  ref="$1" && shift

  base="$(basename "$github")"
  target="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/${base}"

  deploy "$github" "$ref" "$target" "$@"
}

deploy_font_glob() {
  github="$1" && shift
  ref="$1" && shift

  base="$(basename "$github")"
  target="${XDG_DATA_HOME:-$HOME/.local/share}/fonts/${base}"

  # Skip if directory exists to save network requests
  if [[ "${FORCE_UPDATE:-0}" != "1" && -d "$target" ]]; then
    :
  else
    github_glob "$github" "$ref" "$@" | while read filename; do
      deploy "$github" "$ref" "$target" "$filename"
    done
  fi
}

deploy_fontconfig() {
  github="$1" && shift
  ref="$1" && shift

  target="${XDG_CONFIG_HOME:-$HOME/.config}/fontconfig/conf.d"

  deploy "$github" "$ref" "$target" "$@"
}

do_deploy() {
  if [ -s "$ARIAFILE" ]; then
    cat "$ARIAFILE"
    aria2c --auto-file-renaming=false -j16 -i "$ARIAFILE"
  fi
}
