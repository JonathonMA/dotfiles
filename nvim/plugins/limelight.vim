Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

map <Leader>f :Goyo<cr>
