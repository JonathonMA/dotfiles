return {
  {'vim-scripts/utl.vim'},
  {'tpope/vim-speeddating'},
  {'inkarkat/vim-ingo-library'},
  {'inkarkat/vim-SyntaxRange'},
  {'mattn/calendar-vim'},
  {'chrisbra/NrrwRgn'},
  {
    'nvim-orgmode/orgmode.nvim',
    config = function()
      require('orgmode').setup_ts_grammar()
      require('orgmode').setup({
        org_agenda_files = {'~/Dropbox/org/*'},
        org_default_notes_file = '~/Dropbox/org/refile.org',
        org_startup_indented = 'noindent',
      })
    end,
  },
  {
    "akinsho/org-bullets.nvim",
    config = function()
      require("org-bullets").setup {
        symbols = {
          headlines = { "◉", "○", "●", "◈", "◇", "◆", "▣", "□", "■", },
        },
      }
    end,
  },
}
