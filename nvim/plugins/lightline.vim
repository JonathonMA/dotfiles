Plug 'itchyny/lightline.vim'
Plug 'mike-hearn/base16-vim-lightline'

let g:lightline = {
  \ 'component': {
  \   'lineinfo': ' %3l:%-2v',
  \ },
  \ 'component_function': {
  \   'readonly': 'LightlineReadonly',
  \   'fugitive': 'LightlineFugitive'
  \ },
  \ 'separator': { 'left': '', 'right': '' },
  \ 'subseparator': { 'left': '', 'right': '' }
  \ }

let g:lightline.colorscheme = 'base16_default_dark'

let g:lightline.active = {
\  'left': [
\    [ 'mode', 'paste' ],
\    [ 'fugitive', 'readonly', 'filename', 'modified' ]
\  ]
\}

function! LightlineReadonly()
  return &readonly ? '' : ''
endfunction
function! LightlineFugitive()
  if exists('*fugitive#head')
    let branch = fugitive#head()
    return branch !=# '' ? ' '.branch : ''
  endif
  return ''
endfunction
