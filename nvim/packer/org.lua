use 'vim-scripts/utl.vim'
use 'tpope/vim-speeddating'
use 'inkarkat/vim-ingo-library'
use 'inkarkat/vim-SyntaxRange'
use 'mattn/calendar-vim'
use 'chrisbra/NrrwRgn'

use {
  'nvim-orgmode/orgmode.nvim',
  config = function()
    require('orgmode').setup_ts_grammar()
    require('orgmode').setup({
      org_agenda_files = {'~/Dropbox/org/*'},
      org_default_notes_file = '~/Dropbox/org/refile.org',
      org_indent_mode = 'noindent',
    })
  end,
}

use {
  "akinsho/org-bullets.nvim",
  config = function()
    require("org-bullets").setup {
      symbols = {
        headlines = { "◉", "○", "●", "◈", "◇", "◆", "▣", "□", "■", },
      },
    }
  end,
}

vim.filetype.add({
  extension = {
    org = 'org',
  }
})
