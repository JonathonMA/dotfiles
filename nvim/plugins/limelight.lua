return {
  'junegunn/limelight.vim',
  dependencies = { 'junegunn/goyo.vim' },
  config = function()
    vim.cmd [[
      autocmd! User GoyoEnter Limelight
      autocmd! User GoyoLeave Limelight!
      map <Leader>f :Goyo<cr>
    ]]
  end,
}
