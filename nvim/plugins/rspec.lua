return {
  'thoughtbot/vim-rspec',
  config = function()
    vim.cmd [[
      map <Leader>rt :call RunCurrentSpecFile()<CR>
      map <Leader>rs :call RunNearestSpec()<CR>
      map <Leader>rl :call RunLastSpec()<CR>
      map <Leader>ra :call RunAllSpecs()<CR>
    ]]
  end,
}
