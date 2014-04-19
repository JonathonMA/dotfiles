
" Misc. config
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

set autoindent

" Testing
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set laststatus=2
set cursorline
set scrolloff=3
set showmatch
set incsearch
set hlsearch
set ignorecase smartcase
set number
set relativenumber
set backspace=indent,eol,start

" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" Use 256color mode
" Actually want 16 color mode, but if I ever didn't use solarized...
set t_Co=256
