vim.opt.expandtab = false -- Use tabs instead of spaces
vim.opt.tabstop = 2 -- Set tab width
vim.opt.shiftwidth = 2 -- Set indentation width
vim.opt.softtabstop = 2 -- Make <Tab> and <BS> behave consistently
vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cmdheight = 0
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
vim.o.termguicolors = true

vim.opt.fillchars:append({ eob = " " })

local map = vim.keymap.set

-- Colorscheme
local last = vim.fn.stdpath("config") .. "/last_colorscheme.vim"
if vim.fn.filereadable(last) == 1 then
    vim.cmd("source " .. last)
end

map("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer", noremap = true, silent = true })
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close other buffers", noremap = true, silent = true })
map("n", "<leader>bb", "<C-^>", { desc = "Previous buffer", noremap = true, silent = true })
map("n", "<leader>bl", ":bnext<CR>", { desc = "Next buffer", noremap = true, silent = true })
map("n", "<leader>bh", ":bprevious<CR>", { desc = "Previous buffer", noremap = true, silent = true })
map("n", "L", ":bnext<CR>", { desc = "Next buffer", noremap = true, silent = true })
map("n", "H", ":bprevious<CR>", { desc = "Previous buffer", noremap = true, silent = true })

-- window stuff
map("n", "<leader>ws", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>wv", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wq", "<C-W>q", { desc = "Close Window", remap = true })
map("n", "<leader>wq", "<C-W>o", { desc = "Close Other Windows", remap = true })
map("n", "<leader>wh", "<C-W>h", { desc = "Window Left", remap = true })
map("n", "<leader>wl", "<C-W>l", { desc = "Window Right", remap = true })
map("n", "<leader>wj", "<C-W>j", { desc = "Window Down", remap = true })
map("n", "<leader>wk", "<C-W>k", { desc = "Window Up", remap = true })
map("n", "<leader>ww", "<C-W>w", { desc = "Window Next", remap = true })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })

map({ "i", "n", "s" }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
