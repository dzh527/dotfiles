-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>S", function()
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setreg("/", "")
end, { desc = "Remove trailing whitespace" })

vim.keymap.set("n", "Y", "yy", { desc = "Yank line" })

-- Keep jump targets centered while preserving LazyVim's search direction and fold-opening behavior.
vim.keymap.set("n", "G", "Gzz", { desc = "Go to line and center" })
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zvzz'", { expr = true, desc = "Next search result and center" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zvzz'", { expr = true, desc = "Previous search result and center" })
vim.keymap.set("n", "{", "{zz", { desc = "Previous paragraph and center" })
vim.keymap.set("n", "}", "}zz", { desc = "Next paragraph and center" })
