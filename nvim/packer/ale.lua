
use {
  'w0rp/ale',
  config = function()
    vim.cmd [[
      nmap <silent> <C-k> <Plug>(ale_previous_wrap)
      nmap <silent> <C-j> <Plug>(ale_next_wrap)
    ]]

    vim.g.ale_sign_error = "▶"
    vim.g.ale_sign_error = "►"
    vim.g.ale_sign_error = "✘"
    vim.g.ale_sign_warning = "▷"
    vim.g.ale_sign_warning = "▻"
    vim.g.ale_sign_warning = "⚠"
  end,
}
