#!/bin/sh

set -e

cd $(mktemp -d)

wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf
mkdir -p ~/.fonts
mv PowerlineSymbols.otf ~/.fonts

fc-cache -vf ~/.fonts

wget https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf

mkdir -p ~/.config/fontconfig/conf.d/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
