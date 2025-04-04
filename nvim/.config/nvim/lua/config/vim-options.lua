vim.opt.expandtab = false -- Use tabs instead of spaces
vim.opt.tabstop = 4 -- Set tab width
vim.opt.shiftwidth = 4 -- Set indentation width
vim.opt.softtabstop = 4 -- Make <Tab> and <BS> behave consistently
vim.g.mapleader = " "
vim.opt.swapfile = false
vim.opt.relativenumber = true
vim.opt.cmdheight = 0
vim.opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"

vim.opt.fillchars:append({ eob = " " })
