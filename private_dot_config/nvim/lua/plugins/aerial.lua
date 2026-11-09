return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  opts = {},
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons"
  },

  config = function ()
    require("aerial").setup({
      layout = {
        width = 30,
      },
      show_guides = true,
      filter_kind = false,
    })

    vim.keymap.set("n", "<leader>ae", "<CMD>AerialToggle<CR>")
  end
}
