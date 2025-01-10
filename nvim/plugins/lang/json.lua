return require("lib.langutil").support({
  ensure_installed = { "biome" },
  treesitter_install = { "json", "jsonc" },
  formatters_by_ft = {
    json = { "biome" },
    jsonc = { "biome" },
  },
  linters_by_ft = {
    json = { "biomejs" },
    jsonc = { "biomejs" },
  },
})
