vim.opt.expandtab = false -- Use tabs instead of spaces
vim.opt.tabstop = 4 -- Set tab width
vim.opt.shiftwidth = 4 -- Set indentation width
vim.opt.softtabstop = 4 -- Make <Tab> and <BS> behave consistently
vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.cmdheight = 0
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

vim.opt.fillchars:append({ eob = " " })

local map = vim.keymap.set

map("n", "<leader>bd", ":bd<CR>", { desc = "Close buffer", noremap = true, silent = true })
map("n", "<leader>bo", ":%bd|e#|bd#<CR>", { desc = "Close other buffers", noremap = true, silent = true })
map("n", "<leader>bb", "<C-^>", { desc = "Previous buffer", noremap = true, silent = true })
map("n", "<leader>bl", ":bnext<CR>", { desc = "Next buffer", noremap = true, silent = true })
map("n", "<leader>bh", ":bprevious<CR>", { desc = "Previous buffer", noremap = true, silent = true })
map("n", "L", ":bnext<CR>", { desc = "Next buffer", noremap = true, silent = true })
map("n", "H", ":bprevious<CR>", { desc = "Previous buffer", noremap = true, silent = true })

map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { noremap = true, silent = true })

map({ "i", "n", "s" }, "<esc>", function()
    vim.cmd("noh")
    return "<esc>"
end, { expr = true, desc = "Escape and Clear hlsearch" })
