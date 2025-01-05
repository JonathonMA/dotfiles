export MANPATH="${XDG_DATA_HOME:-$HOME/.local/share}/man:$MANPATH"

xdg_cache() { export "$1"="${XDG_CACHE_HOME:-$HOME/.cache}/${2}"; }
xdg_config() { export "$1"="${XDG_CONFIG_HOME:-$HOME/.config}/${2}"; }
xdg_data() { export "$1"="${XDG_DATA_HOME:-$HOME/.local/share}/${2}"; }

xdg_cache HISTFILE bash_history
xdg_cache LESSHISTFILE less_history
xdg_cache NODE_REPL_HISTORY node_repl_history
xdg_cache PSQL_HISTORY psql_history

xdg_config XCOMPOSEFILE X11/xcompose
xdg_config XCOMPOSECACHE X11/xcompose

xdg_config IRBRC irb/irbc

xdg_cache BUNDLE_USER_CACHE bundle
xdg_config BUNDLE_USER_CONFIG bundle
xdg_data BUNDLE_USER_PLUGIN bundle/plugin

unset xdg_cache xdg_config xdg_data
