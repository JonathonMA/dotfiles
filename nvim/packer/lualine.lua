use 'kyazdani42/nvim-web-devicons'
use {
  'hoob3rt/lualine.nvim',
  requires = {'kyazdani42/nvim-web-devicons', opt = true},
  config = function()
    -- TODO: show paste status
    require('lualine').setup{
      sections = {
        lualine_c = {{'filename', symbols = {readonly = ' '}}},
        lualine_z = {{'location', format = function(s) return ' ' .. s end}},
      }
    }
  end,
}
