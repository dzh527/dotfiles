-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.g.mapleader = ","
vim.g.maplocalleader = "\\"
vim.g.autoformat = false
vim.opt.cursorline = true
vim.opt.conceallevel = 0
vim.opt.concealcursor = ""
vim.opt.spelllang = { "en", "cjk" }
vim.opt.smartindent = false
vim.opt.fillchars:append({ vert = "┃" })
vim.opt.updatetime = 500
