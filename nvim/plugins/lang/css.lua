return require("lib.langutil").support({
  ensure_installed = { "biome" },
  formatters_by_ft = {
    css = { "biome" },
    scss = { "biome" },
    less = { "biome" },
  },
  linters_by_ft = {
    css = { "biomejs" },
    scss = { "biomejs" },
    less = { "biomejs" },
  },
})
