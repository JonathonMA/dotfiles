use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} },
  config = function()
    require('telescope').setup({
      defaults = {
        layout_strategy = "bottom_pane",
        layout_config = {
          bottom_pane = {
            height = 18,
          },
        },
      },
    })
  end,
}
