xdg_cache() { export "$1"="${XDG_CACHE_HOME:-$HOME/.cache}/${2}"; }
xdg_config() { export "$1"="${XDG_CONFIG_HOME:-$HOME/.config}/${2}"; }
xdg_data() { export "$1"="${XDG_DATA_HOME:-$HOME/.local/share}/${2}"; }
