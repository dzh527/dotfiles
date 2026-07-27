-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
local function set_window_separator()
  for _, group in ipairs({ "WinSeparator", "VertSplit", "SnacksWinSeparator" }) do
    vim.api.nvim_set_hl(0, group, {
      fg = "#c099ff",
      bold = true,
    })
  end
end

vim.schedule(set_window_separator)

vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    vim.schedule(set_window_separator)
  end,
})
