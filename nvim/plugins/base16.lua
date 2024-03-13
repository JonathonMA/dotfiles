return {
  'RRethy/nvim-base16',
  init = function()
    vim.opt.termguicolors = true -- enable truecolor terminal
    require('base16-colorscheme').load_from_shell()
  end,
}
