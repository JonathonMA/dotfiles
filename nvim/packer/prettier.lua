use('neovim/nvim-lspconfig')
use {
  'jose-elias-alvarez/null-ls.nvim',
  config = function()
    require("null-ls").setup({
      sources = {
        require("null-ls").builtins.diagnostics.eslint,
      },
      on_attach = function(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.cmd("nnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format({ async = true })<CR>")

          -- format on save
          vim.cmd("autocmd BufWritePost <buffer> lua vim.lsp.buf.format({ async = true })")
        end

        if client.server_capabilities.documentRangeFormattingProvider then
          -- NOTE: needs https://github.com/neovim/neovim/pull/19998
          vim.cmd("xnoremap <silent><buffer> <Leader>f :lua vim.lsp.buf.format({ async = true })<CR>")
        end
      end,
    })
  end,
}
use {
  'MunifTanjim/prettier.nvim',
  config = function()
    require("prettier").setup({
      bin = 'prettier',
    })
  end,
}
