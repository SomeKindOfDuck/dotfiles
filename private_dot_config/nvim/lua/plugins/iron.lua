return {
  "Vigemus/iron.nvim",
  event = "VeryLazy",
  config = function()
    local iron = require("iron.core")
    local common = require("iron.fts.common")

    iron.setup({
      config = {
        repl_definition = {
          python = {
            command = { "ipython" },
            format = common.bracketed_paste,
          },
          julia = {
            command = { "julia" },
            format = common.bracketed_paste,
          },
          r = {
            command = { "radian", "--no-save" },
            format = common.bracketed_paste,
          }
        },

        repl_open_cmd = require("iron.view").split.horizontal(15),
      },

      keymaps = {
        visual_send = "<leader><CR>",
        send_line = "<space><CR>",
        exit = "<space>sq",
      },
    })
  end,
}
