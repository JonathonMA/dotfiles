#!/bin/sh
gconf_add_to_list() {
  key="$1"
  value_added="$2"

  current_values=$(gconftool-2 --get /apps/gnome-terminal/global/profile_list | cut -b 2- | cut -f 1-1 -d\])

  if echo $current_values | tr ',' '\n' | grep -q "^$value_added$"; then
    :;
  else
    new_values="$value_added,$current_values"
    gconftool-2 --set --type=list --list-type=string /apps/gnome-terminal/global/profile_list "[$new_values]"
  fi
}

initialize_theme() {
  profile="$1"
  gconftool-2 -s -t string "/apps/gnome-terminal/profiles/$profile/visible_name" "$profile"
  gconftool-2 -s -t string "/apps/gnome-terminal/profiles/$profile/font" "Ubuntu Mono 20"
  gconftool-2 -s -t bool "/apps/gnome-terminal/profiles/$profile/allow_bold" false
  gconftool-2 -s -t bool "/apps/gnome-terminal/profiles/$profile/use_system_font" false
  gconf_add_to_list /apps/gnome-terminal/global/profile_list "$profile"
}

install_colors() {
  profile="$1"
  # bail if already configured
  if [ x"$(gconftool-2 -g /apps/gnome-terminal/profiles/Solarized/use_theme_colors)" = x"false" ]; then
    return
  fi
  tempdir=$(mktemp -d)
  cd "$tempdir"
  git clone https://github.com/sigurdga/gnome-terminal-colors-solarized.git
  cd gnome-terminal-colors-solarized
  ./install.sh -s dark -p "$profile"
}

configure_theme() {
  :
}
set_default_profile() {
  profile="$1"
  gconftool-2 -s -t string "/apps/gnome-terminal/global/default_profile" "$profile"
}

initialize_theme "Solarized"
install_colors "Solarized"
set_default_profile "Solarized"
