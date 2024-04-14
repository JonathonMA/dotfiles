return {
  {'vim-scripts/utl.vim'},
  {'tpope/vim-speeddating'},
  {'inkarkat/vim-ingo-library'},
  {'inkarkat/vim-SyntaxRange'},
  {'mattn/calendar-vim'},
  {'chrisbra/NrrwRgn'},
  {
    'nvim-orgmode/orgmode.nvim',
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    config = function()
      require('orgmode').setup({
        org_agenda_files = {'~/Dropbox/org/*'},
        org_default_notes_file = '~/Dropbox/org/refile.org',
        org_startup_indented = 'noindent',
      })
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = {
      { 'nvim-treesitter/nvim-treesitter', lazy = true },
    },
    opts = {
      org = {
        bullets = { "◉", "○", "●", "◈", "◇", "◆", "▣", "□", "■", },
      },
    },
  },
}
