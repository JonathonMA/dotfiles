lua << LUA
-- https://github.com/nvim-telescope/telescope.nvim/issues/555#issuecomment-785919858
local MakeCommandPicker = function(prompt_title, command)
  local make_entry = require "telescope.make_entry"
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  return function(opts)
    -- By creating the entry maker after the cwd options,
    -- we ensure the maker uses the cwd options when being created.
    opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

    pickers.new(opts, {
      prompt_title = prompt_title,
      finder = finders.new_oneshot_job(
        vim.tbl_flatten( {
          command
        } ),
        opts
      ),
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
    }):find()
  end
end

local builtin = require "telescope.builtin"
builtin.git_modified = MakeCommandPicker('Git Modified Files', 'modified.sh')
builtin.git_branch_modified = MakeCommandPicker('Git Branch Modified Files', 'branch_modified.sh')
builtin.myorg = MakeCommandPicker('Org', 'myorg.sh')
LUA

nnoremap <leader>t <cmd>Telescope find_files<cr>
nnoremap <leader>l <cmd>Telescope buffers<cr>
nnoremap <leader>m <cmd>Telescope git_modified<cr>
nnoremap <leader>M <cmd>Telescope git_branch_modified<cr>
nnoremap <leader>; <cmd>Telescope myorg<cr>
