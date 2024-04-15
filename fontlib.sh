# fontlib.sh -- Install fonts from github
#   requires aria2c to orchestrate downloading missing files to where they should be
set -euo pipefail

if ! command -v aria2c >/dev/null; then
  echo "aria2c not found; not managing fonts"
  exit 0
fi

tmpdir="$(mktemp -d)"
trap '{ rm -rf "${tmpdir?}"; }' EXIT
ARIAFILE="$(mktemp -p "$tmpdir")"

font_path() {
  local font_dir="$1" && shift

  case "$OSTYPE" in
    darwin*)
      echo "$HOME/Library/Fonts/${font_dir}"
      ;;
    linux-gnu*)
      echo "${XDG_DATA_HOME:-$HOME/.local/share}/fonts/${font_dir}"
      ;;
    *)
      echo "Unknown OS: ${OSTYPE}"
      exit 1
      ;;
  esac
}

glob2re() {
  for glob in "$@"; do
    echo "$glob"
  done | sed \
    -e 's,\*\*,DOUBLESTAR,g' \
    -e 's,\*,SINGLESTAR,g' \
    -e 's,SINGLESTAR,[^/]*,g' \
    -e 's,DOUBLESTAR,.*,g' \
    -e 's,^,^,' -e 's,$,$,'
}

github_glob() {
  github="$1" && shift
  ref="$1" && shift

  url="$(printf "https://api.github.com/repos/%s/git/trees/%s?recursive=1" "$github" "$ref")"
  curl -s "$url" | jq -r '.tree | map(.path)[]' | grep -f <(glob2re "$@")
}

zip_glob() {
  zipfile="$1" && shift

  unzip -Z1 "$zipfile" | grep -f <(glob2re "$@")
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
  base="$1" && shift
  github="$1" && shift
  ref="$1" && shift

  target="$(font_path "$base")"

  deploy "$github" "$ref" "$target" "$@"
}

deploy_font_glob() {
  base="$1" && shift
  github="$1" && shift
  ref="$1" && shift

  target="$(font_path "$base")"

  # Skip if directory exists to save network requests
  if [[ "${FORCE_UPDATE:-0}" != "1" && -d "$target" ]]; then
    :
  else
    github_glob "$github" "$ref" "$@" | while read filename; do
      deploy "$github" "$ref" "$target" "$filename"
    done
  fi
}

deploy_font_glob_release() {
  base="$1" && shift
  github="$1" && shift
  name="$1" && shift

  target="$(font_path "$base")"

  if [[ "${FORCE_UPDATE:-0}" != "1" && -d "$target" ]]; then
    :
  else
    url="$(printf "https://api.github.com/repos/%s/releases?page=1&per_page=1" "$github")"
    download_url="$(
      curl \
        -s "$url" \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" |\
        jq --arg name "$name" -r 'first | .assets | map(select(.name == $name)) | first | .browser_download_url'
    )"

    tmp_zipfile="$(mktemp -p "$tmpdir")"
    wget -q --show-progress "$download_url" -O "$tmp_zipfile"
    mkdir -p "$target"
    zip_glob "$tmp_zipfile" "$@" | while read file; do
      filename="$(basename "$file")"
      if [ -f "$target/$filename" ]; then
        :
      else
        echo "$file"
      fi
    done | xargs -d '\n' unzip -j -d "$target" "$tmp_zipfile"
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
