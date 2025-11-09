-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- luacheck: ignore 113
local local_vim = vim
local_vim.o.autoindent = true
local_vim.o.cursorline = true
local_vim.o.expandtab = true
local_vim.o.hidden = true
local_vim.o.hlsearch = false
local_vim.o.number = true
local_vim.o.relativenumber = true
local_vim.o.showmode = false
local_vim.o.smartindent = true
local_vim.o.cindent = true
local_vim.o.splitbelow = true
local_vim.o.splitright = true
local_vim.o.termguicolors = true

local_vim.o.so = 15
local_vim.o.laststatus = 3
local_vim.o.showtabline = 2
local_vim.o.shiftwidth = 2
local_vim.o.cmdheight = 1

local_vim.o.backspace = "indent,eol,start"
local_vim.o.clipboard = "unnamedplus"
local_vim.o.signcolumn = "yes"
local_vim.o.encoding = "utf-8"
local_vim.o.fileencodings = "utf-8"
-- local_vim.o.fillchars = local_vim.o.fillchars .. "eob: "

-- local_vim.o.mouse = local_vim.o.mouse .. "a"
-- local_vim.o.shortmess = local_vim.o.shortmess .. "astWAIc"

local_vim.g.mapleader = " "
local_vim.g.maplocalleader = "\\"

-- lazyvim options
local_vim.g.ai_cmp = true

-- python options
-- LSP Server to use for Python.
-- Set to "basedpyright" to use basedpyright instead of pyright.
local_vim.g.lazyvim_python_lsp = "pyright"
-- Set to "ruff_lsp" to use the old LSP implementation version.
local_vim.g.lazyvim_python_ruff = "ruff"
