return require("lib.langutil").support({
  treesitter_install = { "org" },
  and_also = {
    { "chrisbra/NrrwRgn" },
    { "inkarkat/vim-ingo-library" },
    { "inkarkat/vim-SyntaxRange" },
    { "mattn/calendar-vim" },
    { "tpope/vim-speeddating" },
    { "vim-scripts/utl.vim" },
    {
      "nvim-orgmode/orgmode.nvim",
      dependencies = {
        { "nvim-treesitter/nvim-treesitter", lazy = true },
      },
      config = function()
        require("orgmode").setup({
          org_agenda_files = { "~/Dropbox/org/*" },
          org_default_notes_file = "~/Dropbox/org/refile.org",
          org_startup_indented = false,
        })
      end,
    },
    {
      "lukas-reineke/headlines.nvim",
      dependencies = {
        { "nvim-treesitter/nvim-treesitter", lazy = true },
      },
      opts = {
        org = {
          bullets = { "◉", "○", "●", "◈", "◇", "◆", "▣", "□", "■" },
        },
      },
    },
  },
})
