return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "VeryLazy",
  opts = {},

  config = function ()
    local highlight = {
      "RainbowRed",
      "RainbowOrange",
      "RainbowGreen",
      "RainbowBlue",
      "RainbowViolet",
      "RainbowCyan",
    }

    local hooks = require("ibl.hooks")

    hooks.register(hooks.type.HIGHLIGHT_SETUP, function ()
      vim.api.nvim_set_hl(0, "RainbowRed", {fg = "#FF757F"})
      vim.api.nvim_set_hl(0, "RainbowOrange", {fg = "#FFC777"})
      vim.api.nvim_set_hl(0, "RainbowGreen", {fg = "#C3E88D"})
      vim.api.nvim_set_hl(0, "RainbowBlue", {fg = "#82AAFF"})
      vim.api.nvim_set_hl(0, "RainbowViolet", {fg = "#C099FF"})
      vim.api.nvim_set_hl(0, "RainbowCyan", {fg = "#86E1FC"})
    end)

    require("ibl").setup({ indent = { highlight = highlight } })
  end
}
