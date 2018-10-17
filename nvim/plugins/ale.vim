Plug 'w0rp/ale'

let g:airline#extensions#ale#enabled = 1

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)

let g:ale_sign_error = "◉"
let g:ale_sign_warning = "◉"

let g:ale_set_highlights = 0
