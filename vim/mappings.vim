" SEATTLE FUCKEN' STYLE
map <Leader>s :s/(\([^)]*\))$/ \1/<cr>

" Crappy one-button testing
map <Leader>t :w\|:!~/bin/runtest.rb %<cr>
map <Leader>a :w\|!~/bin/runspec.rb %<cr>
map <Leader>f :w\|!~/bin/runspec.rb % slow<cr>
