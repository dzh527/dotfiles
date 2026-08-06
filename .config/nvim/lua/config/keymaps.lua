-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("n", "<leader>S", function()
  vim.cmd([[%s/\s\+$//e]])
  vim.fn.setreg("/", "")
end, { desc = "Remove trailing whitespace" })

vim.keymap.set("n", "Y", "yy", { desc = "Yank line" })
