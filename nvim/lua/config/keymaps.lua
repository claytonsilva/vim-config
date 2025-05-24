-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- luacheck: ignore
local map = vim.keymap.set

map("n", "<leader>k", function()
  Snacks.terminal("k9s", { cwd = LazyVim.root(), auto_close = true })
end, { desc = "K9s" })

map("n", "<leader>gg", function()
  Snacks.terminal("lazygit", { cwd = LazyVim.root(), auto_close = true })
end, { desc = "LazyGit (Root)" })
