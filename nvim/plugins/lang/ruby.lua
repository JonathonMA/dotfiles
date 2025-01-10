return require("lib.langutil").support({
  ensure_installed = { "erb-formatter", "erb-lint", "rubocop" },
  treesitter_install = { "ruby" },
  formatters_by_ft = {
    ruby = { "rubocop" },
    eruby = { "erb_format" },
  },
  linters_by_ft = {
    ruby = { "rubocop" },
  },
  and_also = {
    { "vim-ruby/vim-ruby" },
    { "tpope/vim-rails" },
    {
      "nvim-neotest/neotest",
      optional = true,
      dependencies = {
        "olimorris/neotest-rspec",
      },
      -- opts = {
      --   adapters = {
      --     ["neotest-rspec"] = {
      --       -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
      --       -- rspec_cmd = function()
      --       --   return vim.tbl_flatten({
      --       --     "bundle",
      --       --     "exec",
      --       --     "rspec",
      --       --   })
      --       -- end,
      --     },
      --   },
      -- },
    },
  },
})
