return {
  "nvim-telescope/telescope-file-browser.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },

  config = function ()
    vim.keymap.set("n", "<space>fe", "<CMD>Telescope file_browser<CR>", { noremap = true })
  end
}
