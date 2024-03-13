return {
  'christoomey/vim-titlecase',
  config = function()
    vim.cmd [[
      nmap <leader>gz  <Plug>Titlecase
      vmap <leader>gz  <Plug>Titlecase
      nmap <leader>gzz <Plug>TitlecaseLine
    ]]
  end,
}

