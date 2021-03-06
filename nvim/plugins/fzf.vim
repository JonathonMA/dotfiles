" Stolen from nathanaelkane/dotfiles

Plug 'junegunn/fzf', { 'dir': '~/.local/share/fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Hide statusline
autocmd! FileType fzf
autocmd  FileType fzf set laststatus=0 noshowmode noruler
      \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler

let g:fzf_command_prefix = 'Fzf'
let g:fzf_layout = {
  \   'window': 'botright 10split enew',
\ }

command! -bang FzfModified
  \ call fzf#run(extend({
  \   'source': 'modified.sh',
  \   'sink': 'e',
  \   'options': '--prompt="Modified> "',
  \ }, g:fzf_layout))

command! -bang FzfBranchModified
  \ call fzf#run(extend({
  \   'source': 'branch_modified.sh',
  \   'sink': 'e',
  \   'options': '--prompt="BranchModified> "',
  \ }, g:fzf_layout))

command! -bang FzfTagJump
  \ call fzf#vim#tags(
  \   expand('<cword>'),
  \   {'options': '--select-1 --exact'},
  \   <bang>0
  \ )

map <silent> <leader>t :FzfFiles<CR>
map <silent> <leader>l :FzfBuffers<CR>
map <silent> <leader>m :FzfModified<CR>
map <silent> <leader>M :FzfBranchModified<CR>
map <silent> <leader>d :exe 'FzfFiles ' . expand('%:p:h', 1)<CR>
map <silent> <C-]> :FzfTagJump<CR>
