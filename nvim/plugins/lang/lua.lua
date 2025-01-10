return require("lib.langutil").support({
  treesitter_install = { "lua", "luadoc", "luap" },
  ensure_installed = { "luacheck", "stylua" },
  formatters_by_ft = { lua = { "stylua" } },
  linters_by_ft = { lua = { "luacheck" } },
})
