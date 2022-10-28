use {
  'nvim-treesitter/nvim-treesitter',
  run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  config = function()
    require('nvim-treesitter.configs').setup {
      ensure_installed = {
        "c",
        "cpp",
        "javascript",
        "lua",
        "ruby",
      },
      highlight = {
        enable = true,
      },
    }
  end,
}
