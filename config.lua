-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

local local_vim = vim -- luacheck:ignore 113
local local_lvim = lvim -- luacheck:ignore 113
-- plugins declaration
lvim.plugins = { -- luacheck:ignore 112
	-- test suite
	{
		"nvim-neotest/neotest",
		branch = "v5.8.0",
		dependencies = {
			"nvim-neotest/neotest-python",
			"nvim-neotest/neotest-go",
			"nvim-neotest/neotest-jest",
			"rouge8/neotest-rust",
			"nvim-neotest/nvim-nio",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-lua/plenary.nvim",
		},
	},
	-- linters and formarters (efm instead null-ls)
	{
		"creativenull/efmls-configs-nvim",
		version = "v1.9.0",
		dependencies = { "neovim/nvim-lspconfig" },
	},
	-- yaml schemas
	{
		"someone-stole-my-name/yaml-companion.nvim",
		branch = "0.1.3",
		ft = { "yaml" },
		dependencies = {
			{ "neovim/nvim-lspconfig" },
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-telescope/telescope.nvim" },
		},
	},
	-- copilot
	{
		"github/copilot.vim",
		event = "VeryLazy",
		config = function()
			-- copilot assume mapeado
			local_vim.g.copilot_assume_mapped = true
			local_vim.g.copilot_no_tab_map = true
		end,
	},
	{
		"hrsh7th/cmp-copilot",
		config = function()
			local_lvim.builtin.cmp.formatting.source_names["copilot"] = "( )"
			table.insert(local_lvim.builtin.cmp.sources, 2, { name = "copilot" })
		end,
	},
	-- dap suites
	"mfussenegger/nvim-dap-python",
	"leoluz/nvim-dap-go",
}
--require('user.tests')
require("user.python")
require("user.tests")
require("user.lsp")
require("user.efm")
require("user.go")
--require('user.rust')
--require('user.terraform')
--require('user.terminal')
-- require('user.lua')
require("user.k8s")
