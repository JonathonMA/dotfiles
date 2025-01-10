-- https://github.com/nvim-telescope/telescope.nvim/issues/555#issuecomment-785919858
local makeCommandPicker = function(prompt_title, command)
  local make_entry = require("telescope.make_entry")
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values
  return function(opts)
    -- By creating the entry maker after the cwd options,
    -- we ensure the maker uses the cwd options when being created.
    opts.entry_maker = opts.entry_maker or make_entry.gen_from_file(opts)

    pickers
      .new(opts, {
        prompt_title = prompt_title,
        finder = finders.new_oneshot_job(
          vim.tbl_flatten({
            command,
          }),
          opts
        ),
        previewer = conf.file_previewer(opts),
        sorter = conf.file_sorter(opts),
      })
      :find()
  end
end

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>t", "<cmd>Telescope find_files<cr>", desc = "Open file" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Open buffer" },
    { "<leader>fm", "<cmd>Telescope git_modified<cr>", desc = "Open modified" },
    { "<leader>fM", "<cmd>Telescope git_branch_modified<cr>", desc = "Open modified in branch" },
    { "<leader>f;", "<cmd>Telescope myorg<cr>", desc = "Open org" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
  },
  config = function()
    require("telescope").setup({
      defaults = {
        layout_strategy = "bottom_pane",
        layout_config = {
          bottom_pane = {
            height = 18,
          },
        },
      },
    })

    local builtin = require("telescope.builtin")
    builtin.git_modified = makeCommandPicker("Git Modified Files", "modified.sh")
    builtin.git_branch_modified = makeCommandPicker("Git Branch Modified Files", "branch_modified.sh")
    builtin.myorg = makeCommandPicker("Org", "myorg.sh")
  end,
}
