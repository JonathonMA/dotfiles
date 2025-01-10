local langutil = {}

function langutil.support(opts)
  base = opts.and_also or {}

  base[#base+1] = {
    "mason.nvim",
    optional = true,
    opts = { ensure_installed = opts.ensure_installed },
  }

  base[#base+1] = {
    "stevearc/conform.nvim",
    optional = true,
    opts = { formatters_by_ft = opts.formatters_by_ft },
  }

  base[#base+1] = {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = { linters_by_ft = opts.linters_by_ft },
  }

  base[#base+1] = {
    "nvim-treesitter/nvim-treesitter",
    optional = true,
    opts = { ensure_installed = opts.treesitter_install },
  }

  return base
end

return langutil
