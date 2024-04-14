-- FIX: fixme
-- XXX: xxx
-- WARN: warn
-- HACK: hack
-- TEST: test
-- NOTE: note
-- TODO: todo
-- PERF: perf

return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    keywords = {
      FIX = { color = "red" },
      WARN = { color = "orange" },
      HACK = { color = "yellow" },
      NOTE = { color = "blue" },
      PERF = { color = "indigo" },
      TODO = { icon = "󰧉", color = "magenta" },
      TEST = { icon = "", color = "green" },
    },
    colors = {
      red = { "TSVariable" },
      orange = { "TSNumber" },
      yellow = { "TSLabel" },
      green = { "TSString" },
      cyan = { "TSStringRegex" },
      blue = { "TSFunction" },
      indigo = { "TSKeyword" },
      magenta = { "TSTagDelimiter" },
    },
  },
}
