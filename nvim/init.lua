require('init_vim')
require('plugins')

-- :help sd
vim.opt.shada = {
  '!', -- Save / reload global variables
  "'100", -- Maximum number of previously edited files for which the marks are remembered
  "<500", -- Lines saved per register
  "s10", -- Maximum size of item content in KiB
  "h", -- Disable hlsearch when loading shada
}
