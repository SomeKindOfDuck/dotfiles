vim.cmd("autocmd!")
local opt = vim.opt

opt.termguicolors = true
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

opt.mouse = ""
opt.signcolumn = "yes"
opt.number = true
vim.wo.number = true
vim.wo.relativenumber = true
vim.opt.splitbelow = true
opt.cursorline = true
opt.cursorcolumn = true
opt.swapfile = false
opt.wrap = true
opt.list = true
opt.listchars = { tab = ">>", trail = "-", nbsp = "+", space = "⋅", eol = "↴"}
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.clipboard = "unnamedplus"
