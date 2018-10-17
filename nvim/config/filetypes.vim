" Custom widths
autocmd bufreadpre *.slim setlocal textwidth=0
autocmd bufreadpre *.sass setlocal textwidth=0
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType ruby setlocal textwidth=80
autocmd FileType cucumber setlocal nowrap
autocmd FileType ruby setlocal iskeyword+=?
autocmd FileType mkd setlocal textwidth=66

" *.c indent 8
autocmd FileType c setlocal tabstop=8

" *.php indent 4
autocmd Filetype php setlocal sts=4 ts=4 sw=4

" Show the textwidth
set colorcolumn=+1
