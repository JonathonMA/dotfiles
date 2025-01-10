return {
  'junegunn/limelight.vim',
  dependencies = { 'junegunn/goyo.vim' },
  keys = {
    { "<leader>z", "<cmd>:Goyo<cr>", desc = "Zen mode" },
  },
  config = function()
    vim.cmd [[
      autocmd! User GoyoEnter Limelight
      autocmd! User GoyoLeave Limelight!
    ]]
  end,
}
