return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[set background=dark]])
      vim.cmd([[colorscheme tokyonight-moon]])
      vim.cmd("highlight Normal ctermbg=none guibg=none")
      vim.cmd("highlight NormalNC ctermbg=none guibg=none")
      vim.cmd("highlight NonText ctermbg=none guibg=none")
      vim.cmd("highlight Folded ctermbg=none guibg=none")
      vim.cmd("highlight EndOfBuffer ctermbg=none guibg=none")
      vim.cmd("highlight LineNr ctermbg=none guibg=none")
      vim.cmd("highlight SignColumn ctermbg=none guibg=none")
      vim.cmd("highlight NormalFloat ctermbg=none guibg=none")
      vim.cmd("highlight FloatBorder ctermbg=none guibg=none")
    end
  },
}
