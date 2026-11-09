-- general settings
vim.g.mapleader = " "
local set = vim.keymap.set
local opts = { noremap = true, silent = true }

-- yank settings
set("n", "x", '"_x', opts)
set("n", "py", "\"0p")
set("n", "pd", "p")

-- move cursor
set("n", "j", "gj")
set("n", "gj", "j")
set("n", "k", "gk")
set("n", "gk", "k")

set("i", "<C-h>", "<LEFT>")
-- set("i", "<C-j>", "<DOWN>")
-- set("i", "<C-k>", "<UP>")
set("i", "<C-l>", "<RIGHT>")

-- window
set("n", "<leader>k", "<CMD>sp<CR>")
set("n", "<leader>j", "<CMD>sp<CR><C-w>j")
set("n", "<leader>h", "<CMD>vs<CR>")
set("n", "<leader>l", "<CMD>vs<CR><C-w>l")

set("n", "<leader>q", "<CMD>q<CR>")

set("n", "<C-h>", "<C-w>h")
set("n", "<C-j>", "<C-w>j")
set("n", "<C-k>", "<C-w>k")
set("n", "<C-l>", "<C-w>l")

set("n", "<S-LEFT>", "<CMD>vertical resize -3<CR>")
set("n", "<S-DOWN>", "<CMD>resize +3<CR>")
set("n", "<S-UP>", "<CMD>resize -3<CR>")
set("n", "<S-RIGHT>", "<CMD>vertical resize +3<CR>")

set("t", "<C-h>", "<CMD>wincmd h<CR>")
set("t", "<C-j>", "<CMD>wincmd j<CR>")
set("t", "<C-k>", "<CMD>wincmd k<CR>")
set("t", "<C-l>", "<CMD>wincmd l<CR>")

-- add and delete a line
set("n", "K", "J")
set("n", "J", "<CMD>call append(line(\".\"), \"\")<CR>")
set("n", "L", "li <ESC>h")
set("n", "H", "lxh")

-- indent
set("n", ">", ">>")
set("n", "<", "<<")
set("v", ">", ">gv")
set("v", "<", "<gv")

-- turn off highlighit
set("n", "<ESC>", ":noh<CR>")

-- mode change
set("i", "jj", "<ESC>")
set("t", "jj", "<C-\\><C-n>")
