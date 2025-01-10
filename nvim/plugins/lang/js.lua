return require("lib.langutil").support({
  ensure_installed = { "biome" },
  treesitter_install = { "javascript", "jsdoc", "tsx", "typescript" },
  formatters_by_ft = {
    javascript = { "biome" },
    javascriptreact = { "biome" },
    typescript = { "biome" },
    typescriptreact = { "biome" },
    vue = { "biome" },
  },
  linters_by_ft = {
    javascript = { "biomejs" },
    javascriptreact = { "biomejs" },
    typescript = { "biomejs" },
    typescriptreact = { "biomejs" },
    vue = { "biomejs" },
  },
})
