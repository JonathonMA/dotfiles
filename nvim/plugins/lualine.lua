return {
  {
    'ducklin5/lualine.nvim', branch = 'fix/tintedBase16',
    dependencies = {{'nvim-tree/nvim-web-devicons', optional = true}},
    config = function()
      -- TODO: show paste status
      require('lualine').setup{
        sections = {
          lualine_c = {{'filename', symbols = {readonly = ' '}}},
          lualine_z = {{'location', format = function(s) return ' ' .. s end}},
          lualine_x = {
            {
              require("lazy.status").updates,
              cond = require("lazy.status").has_updates,
              color = { fg = "#ff9e64" },
            },
          },
        }
      }
    end,
  }
}
