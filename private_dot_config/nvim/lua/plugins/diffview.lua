return {
  "sindrets/diffview.nvim",
  event = "VeryLazy",

  config = function ()
    require("diffview").setup({
      hooks = {
        view_opened = function(view)
          vim.keymap.set("n", "-d", "<CMD>DiffviewClose<CR>")
        end,
        view_closed = function(view)
          vim.keymap.set("n", "-d", "<CMD>DiffviewOpen<CR>")
        end,
      }
    })

    vim.keymap.set("n", "-d", "<CMD>DiffviewOpen<CR>")
  end
}
