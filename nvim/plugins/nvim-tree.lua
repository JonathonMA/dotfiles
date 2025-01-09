return {
  {
    'nvim-tree/nvim-tree.lua',
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons", },
    opts = { actions = { open_file = { quit_on_open = true, }, }, },
    keys = {
      { "<leader>e", "<cmd>:NvimTreeToggle<cr>", desc = "nvim-tree" },
      { "<leader>q", "<cmd>:NvimTreeToggle<cr>", desc = "nvim-tree" },
    },
  },
}
