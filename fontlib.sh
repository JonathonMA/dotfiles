# fontlib.sh -- Install fonts from github
#   requires aria2c to orchestrate downloading missing files to where they should be
set -euo pipefail


REQUIRED_COMMANDS="aria2c jq"
read -a commands <<< "${REQUIRED_COMMANDS}"

for command in "${commands[@]}"; do
  if ! command -v $command >/dev/null; then
    echo "${command} not found; not managing fonts"
    exit 0
  fi
done

tmpdir="$(mktemp -d)"
trap '{ rm -rf "${tmpdir?}"; }' EXIT
ARIAFILE="$(mktemp -p "$tmpdir" "aria2c.XXXX.txt")"

os-font-path() {
  case "$OSTYPE" in
    darwin*)
      echo "$HOME/Library/Fonts"
      ;;
    linux-gnu*)
      echo "${XDG_DATA_HOME:-$HOME/.local/share}/fonts"
      ;;
    *)
      echo "Unknown OS: ${OSTYPE}"
      exit 1
      ;;
  esac
}

sed_escape-zip-wildcard() {
cat <<SED
s/\([][?*]\)/\\\\\1/g
SED
}

sed_glob2re() {
  local single_star="$(uuidgen)"
  local double_star="$(uuidgen)"

cat <<SED
s/\*\*/${double_star}/g
s/\*/${single_star}/g
s|${single_star}|[^/]*|g
s/${double_star}/.*/g
s/^/^/
s/$/$/
SED
}

glob2re() {
  printf "%s\n" "$@" | sed -f <(sed_glob2re)
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

zip_unpack() {
  target="$1" && shift
  tmp_archive="$1" && shift

  sed -f <(sed_escape-zip-wildcard) | xargs -d '\n' unzip -j -d "$target" "$tmp_archive"
}

tar_glob() {
  tarball="$1" && shift

  tar -tf "$tarball" | grep -f <(glob2re "$@")
}

tar_unpack() {
  target="$1" && shift
  tmp_archive="$1" && shift

  xargs -d '\n' tar -C "$target" --verbose --extract --file "$tmp_archive" --transform 's/.*\///'
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

deploy_font_gh() {
  base="$1" && shift
  github="$1" && shift
  ref="$1" && shift

  target="${font_path}/${base}"

  with-font-target "$target" github_glob "$github" "$ref" "$@" | while read filename; do
    deploy "$github" "$ref" "$target" "$filename"
  done
}

process-archive-url() {
  local target="$1" && shift
  local archive_url="$1" && shift
  local archive_name="$1" && shift

  case "$archive_name" in
    *.zip|*.ZIP)
      archive_ext="zip"
      archive_glob=zip_glob
      archive_unpack=zip_unpack
      ;;
    *.tar.zst)
      archive_ext="tar.zst"
      archive_glob=tar_glob
      archive_unpack=tar_unpack
      ;;
    *)
      echo "Unknown archive type: ${archive_name}"
      exit 1
  esac

  tmp_archive="$(mktemp -p "$tmpdir" "fontlib.XXXXXXXX.${archive_ext}")"
  wget -q --show-progress "$archive_url" -O "$tmp_archive"
  mkdir -p "$target"
  "${archive_glob}" "$tmp_archive" "$@" | while read file; do
    filename="$(basename "$file")"
    if [ -f "$target/$filename" ]; then
      :
    else
      echo "$file"
    fi
  done | "${archive_unpack}" "$target" "$tmp_archive"
}

fetch-then-process-github-release() {
  local target="$1" && shift
  local url="$1" && shift
  local archive_name="$1" && shift

  download_url="$(
    curl \
      -s "$url" \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" |\
      jq --arg name "$archive_name" -r 'first | .assets | map(select(.name == $name)) | first | .browser_download_url'
  )"

  process-archive-url "$target" "$download_url" "$archive_name" "$@"
}

# do no work if the directory already exists unless specifically asked
with-font-target() {
  target="$1" && shift

  if [[ "${FORCE_UPDATE:-0}" != "1" && -d "$target" ]]; then
    :
  else
    "$@"
  fi
}

deploy_font_gh_release() {
  base="$1" && shift
  github="$1" && shift
  archive_name="$1" && shift

  target="${font_path}/${base}"
  url="$(printf "https://api.github.com/repos/%s/releases?page=1&per_page=1" "$github")"

  with-font-target "$target" fetch-then-process-github-release "$target" "$url" "$archive_name" "$@"
}

deploy_font_archive() {
  base="$1" && shift
  download_url="$1" && shift

  archive_name="$(basename "$download_url")"
  target="${font_path}/${base}"

  with-font-target "$target" process-archive-url "$target" "$download_url" "$archive_name" "$@"
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

font_path="$(os-font-path)"
