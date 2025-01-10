return require("lib.langutil").support({
  ensure_installed = { "shfmt" },
  treesitter_install = { "bash" },
  formatters_by_ft = { sh = { "shfmt" } },
})
