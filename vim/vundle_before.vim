
let run_bundle_install = 0

let bundle_dir = expand("$XDG_DATA_HOME/vim/bundle/")

if !isdirectory(expand(bundle_dir.'/vundle/'))
  silent !echo "Installing Vundle..."
  silent execute '!mkdir -p '.bundle_dir
  silent execute '!git clone https://github.com/gmarik/vundle '.bundle_dir.'vundle'

  "silent !mkdir -p $MYVIMDIR/bundle
  "silent !git clone https://github.com/gmarik/vundle $MYVIMDIR/bundle/vundle
  let run_bundle_install = 1
endif

set nocompatible
filetype off

" set rtp+=bundle_dir.'vundle/'
exec 'set rtp^='.bundle_dir.'vundle/'

call vundle#rc(bundle_dir)

Bundle "gmarik/vundle"
