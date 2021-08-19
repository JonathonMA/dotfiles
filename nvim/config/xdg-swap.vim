" Swap should use ~/.cache
" Extra "tmp" directory included to work around swap rename issue with "//" directive
call mkdir($HOME . "/.cache/nvim/tmp/" , 'p')
set directory=$HOME/.cache/nvim/swap//,$HOME/.cache/nvim/tmp/
