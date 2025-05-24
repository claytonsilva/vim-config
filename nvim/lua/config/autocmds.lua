-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
--
--
-- Disable lsp for helm values files
local local_vim = vim -- luacheck:ignore 113
local_vim.api.nvim_create_autocmd("LspAttach", {
  group = local_vim.api.nvim_create_augroup("DisableLspForValues", {}),
  pattern = { "values.yaml", "value*.yml", "value*.yaml", "*values.yaml", "*values.yml" },
  command = "LspStop",
})
