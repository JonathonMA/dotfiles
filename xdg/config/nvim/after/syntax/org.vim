" Enable syntax highlighting for BEGIN_SRC embeds
if exists('g:loaded_SyntaxRange')
  let langs = [
    \ 'json',
    \ 'markdown',
    \ 'ruby',
    \ 'sql',
    \ ]

  for lang in langs
    call SyntaxRange#Include('#+BEGIN_SRC ' . lang, '#+END_SRC', lang, 'comment')
  endfor
endif
