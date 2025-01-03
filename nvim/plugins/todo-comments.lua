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
      background = { "tinted_gui00" },
      foreground = { "tinted_gui05" },

      black = { "tinted_gui01" },
      bright_black = { "tinted_gui02" },
      grey = { "tinted_gui03" },
      light_grey = { "tinted_gui04" },
      white = { "tinted_gui06" },
      bright_white = { "tinted_gui07" },

      red = { "tinted_gui08" },
      orange = { "tinted_gui09" },
      yellow = { "tinted_gui0A" },
      green = { "tinted_gui0B" },
      cyan = { "tinted_gui0C" },
      blue = { "tinted_gui0D" },
      indigo = { "tinted_gui0E" },
      magenta = { "tinted_gui0F" },
    },
  },
}
