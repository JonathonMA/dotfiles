" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>

" SEATTLE FUCKEN' STYLE
map <Leader>s :s/(\([^)]*\))$/ \1/<cr>

" Crappy one-button testing
"map <Leader>t :w\|:!~/bin/runtest.rb %<cr>
"map <Leader>a :w\|!~/bin/runspec.rb %<cr>
"map <Leader>f :w\|!~/bin/runspec.rb % slow<cr>

"map <Leader>c :w\|:!cucumber -p rerun<cr>
"map <Leader>w :w\|:!cucumber-web -p rerun<cr>

map <Leader>tc :w\|:!cucumber -p rerun<cr>
map <Leader>tw :w\|:!cucumber -p wip<cr>
map <Leader>ts :w\|:!cucumber-web -p rerun<cr>
map <Leader>trw :w\|:!rspec --tag wip<cr>
map <Leader>trr :w\|:!rspec %<cr>
map <Leader>tm :w\|:!ruby -Itest %<cr>

map <Leader>rc :w\|:!rubocop %<cr>
