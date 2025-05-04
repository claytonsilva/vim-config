-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- plugins declaration
lvim.plugins = { -- luacheck:ignore 112
	-- test suite
	{
		"nvim-neotest/neotest",
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
	{
		"JannoTjarks/tflint.nvim",
		version = "*",
		dependencies = {
			"neovim/nvim-lspconfig",
		},
		lazy = true,
		ft = "terraform",
		config = function()
			require("tflint").setup({ tflint_path = "~/.local/bin/tflint" })
		end,
	},
	-- yaml schemas and helm templates
	{
		"towolf/vim-helm",
		ft = { "helm" },
	},
	-- copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
	},
	{
		"zbirenbaum/copilot-cmp",
	},
	{
		"onsails/lspkind.nvim",
	},
	-- dap suites
	"mfussenegger/nvim-dap-python",
	"leoluz/nvim-dap-go",
	-- misc lsp helpers
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		-- branch = "develop"
		-- (optional) will update plugin's deps on every update
		opts = {},
	},
	-- Kubernetes Schema generator
	{
		"diogo464/kubernetes.nvim",
		opts = {
			-- this can help with autocomplete. it sets the `additionalProperties`
			-- field on type definitions to false if it is not already present.
			schema_strict = true,
			-- true:  generate the schema every time the plugin starts
			-- false: only generate the schema if the files don't already exists.
			--        run `:KubernetesGenerateSchema` manually to generate the schema if needed.
			schema_generate_always = false,
		},
	},
	-- misc other plugins
	{
		"LukasPietzschmann/telescope-tabs",
		dependencies = { "nvim-telescope/telescope.nvim" },
	},
	{
		"MagicDuck/grug-far.nvim",
		version = "v1.6.3",
	},
	{
		"voldikss/vim-floaterm",
	},
	{
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
	},
}
require("user.python")
require("user.tests")
require("user.lsp")
require("user.efm")
require("user.go")
--require('user.rust')
require("user.options")
require("user.k8s")
require("user.copilot")
require("user.lspkind")
require("user.keybindings")
require("user.lualine")
