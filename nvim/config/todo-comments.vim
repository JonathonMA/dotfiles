let mapping = {
\ "FIX": "red",
\ "TODO": "cyan",
\ "HACK": "yellow",
\ "WARN": "yellow",
\ "PERF": "magenta",
\ "NOTE": "green",
\}
for kw in keys(mapping)
  let s:colorName = mapping[kw]
  let fg = 'black'
  let sign_bg = 'None'

  execute("hi def TodoBg" .. kw .. " ctermbg=" .. s:colorName .. " ctermfg=" .. fg .. " cterm=bold")
  execute("hi def TodoFg" .. kw .. " ctermbg=NONE ctermfg=" .. s:colorName .. " cterm=NONE")
  execute("hi def TodoSign" .. kw .. " ctermbg=" .. sign_bg .. " ctermfg=" .. s:colorName .. " cterm=NONE")
endfor
