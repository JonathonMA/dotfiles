lua << LUA
-- TODO: show paste status
require('lualine').setup{
  options = { theme  = 'auto' },
  sections = {
    lualine_c = {{'filename', symbols = {readonly = ' '}}},
    lualine_z = {{'location', format = function(s) return ' ' .. s end}},
  }
}
LUA
