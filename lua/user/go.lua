-- luacheck: ignore 113
require("dap-go").setup({
	-- Additional dap configurations can be added.
	-- dap_configurations accepts a list of tables where each entry
	-- represents a dap configuration. For more details do:
	-- :help dap-configuration
	dap_configurations = {
		{
			-- Must be "go" or it will be ignored by the plugin
			type = "go",
			name = "Attach remote",
			mode = "remote",
			request = "attach",
		},
	},
	-- delve configurations
	delve = {
		-- the path to the executable dlv which will be used for debugging.
		-- by default, this is the "dlv" executable on your PATH.
		path = "dlv",
		-- time to wait for delve to initialize the debug session.
		-- default to 20 seconds
		initialize_timeout_sec = 20,
		-- a string that defines the port to start delve debugger.
		-- default to string "${port}" which instructs nvim-dap
		-- to start the process in a random available port.
		-- if you set a port in your debug configuration, its value will be
		-- assigned dynamically.
		port = "${port}",
		-- additional args to pass to dlv
		args = {},
		-- the build flags that are passed to delve.
		-- defaults to empty string, but can be used to provide flags
		-- such as "-tags=unit" to make sure the test suite is
		-- compiled during debugging, for example.
		-- passing build flags using args is ineffective, as those are
		-- ignored by delve in dap mode.
		-- avaliable ui interactive function to prompt for arguments get_arguments
		build_flags = {},
		-- whether the dlv process to be created detached or not. there is
		-- an issue on delve versions < 1.24.0 for Windows where this needs to be
		-- set to false, otherwise the dlv server creation will fail.
		-- avaliable ui interactive function to prompt for build flags: get_build_flags
		detached = vim.fn.has("win32") == 0,
		-- the current working directory to run dlv from, if other than
		-- the current working directory.
		cwd = nil,
	},
	-- options related to running closest test
	tests = {
		-- enables verbosity when running the test.
		verbose = false,
	},
})

------------------------
-- LSP
------------------------
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "gopls" })

local lsp_manager = require("lvim.lsp.manager")
-- TODO solve golangci_lint_ls
-- lsp_manager.setup("golangci_lint_ls", {
-- 	on_init = require("lvim.lsp").common_on_init,
-- 	capabilities = require("lvim.lsp").common_capabilities(),
-- })

lsp_manager.setup("gopls", {
	on_attach = function(client, bufnr)
		require("lvim.lsp").common_on_attach(client, bufnr)
		local _, _ = pcall(vim.lsp.codelens.refresh)
		local map = function(mode, lhs, rhs, desc)
			if desc then
				desc = desc
			end

			vim.keymap.set(mode, lhs, rhs, { silent = true, desc = desc, buffer = bufnr, noremap = true })
		end
		-- TODO mix all shortcuts in single file
    map("n", "<leader>Ci", "<cmd>GoInstallDeps<Cr>", "Install Go Dependencies")
		map("n", "<leader>Ct", "<cmd>GoMod tidy<cr>", "Tidy")
		map("n", "<leader>Ca", "<cmd>GoTestAdd<Cr>", "Add Test")
		map("n", "<leader>CA", "<cmd>GoTestsAll<Cr>", "Add All Tests")
		map("n", "<leader>Ce", "<cmd>GoTestsExp<Cr>", "Add Exported Tests")
		map("n", "<leader>Cg", "<cmd>GoGenerate<Cr>", "Go Generate")
		map("n", "<leader>Cf", "<cmd>GoGenerate %<Cr>", "Go Generate File")
		map("n", "<leader>Cc", "<cmd>GoCmt<Cr>", "Generate Comment")
		map("n", "<leader>DT", "<cmd>lua require('dap-go').debug_test()<cr>", "Debug Test")
	end,
	on_init = require("lvim.lsp").common_on_init,
	capabilities = require("lvim.lsp").common_capabilities(),
	settings = {
		gopls = {
			usePlaceholders = true,
			gofumpt = true,
			codelenses = {
				generate = false,
				gc_details = true,
				test = true,
				tidy = true,
			},
		},
	},
})

local status_ok, gopher = pcall(require, "gopher")
if not status_ok then
	return
end

gopher.setup({
	commands = {
		go = "go",
		gomodifytags = "gomodifytags",
		gotests = "gotests",
		impl = "impl",
		iferr = "iferr",
	},
})
