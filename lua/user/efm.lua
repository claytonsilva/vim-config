-- Register linters and formatters per language
-- javascript, typescript
local eslint = require("efmls-configs.linters.eslint")
local prettier = require("efmls-configs.formatters.prettier")
local xo = require("efmls-configs.linters.xo")
-- lua
local stylua = require("efmls-configs.formatters.stylua")
local luacheck = require("efmls-configs.linters.luacheck")
-- docker
local hadolint = require("efmls-configs.linters.hadolint")
-- golang
local golangci_lint = require("efmls-configs.linters.golangci_lint")
local gofmt = require("efmls-configs.formatters.gofmt")
local goimports = require("efmls-configs.formatters.goimports")
-- json
local jq_linter = require("efmls-configs.linters.jq")
local jq_formatter = require("efmls-configs.formatters.jq")
-- python
local flake8 = require("efmls-configs.linters.flake8")
local autopep8 = require("efmls-configs.formatters.autopep8")
-- rust
local rustfmt = require("efmls-configs.formatters.rustfmt")
-- terraform
local terraform_fmt = require("efmls-configs.formatters.terraform_fmt")
-- yaml
local yamllint = require("efmls-configs.linters.yamllint")
local actionlint = require("efmls-configs.linters.actionlint")
-- css/sccss
local stylelint = require("efmls-configs.linters.stylelint")

local languages = {
	html = { prettier },
	css = { prettier, stylelint },
	scss = { prettier, stylelint },
	less = { prettier, stylelint },
	javascript = { eslint, prettier, xo },
	typescript = { eslint, prettier, xo },
	lua = { stylua, luacheck },
	go = { golangci_lint, gofmt, goimports },
	docker = { hadolint },
	json = { jq_linter, jq_formatter },
	python = { flake8, autopep8 },
	rust = { rustfmt },
	terraform = { terraform_fmt },
	yaml = { prettier, actionlint, yamllint },
}

-- Or use the defaults provided by this plugin
-- check doc/SUPPORTED_LIST.md for the supported languages
--
-- local languages = require('efmls-configs.defaults').languages()
local local_vim = vim -- luacheck:ignore 113

local efmls_config = {
	filetypes = local_vim.tbl_keys(languages),
	settings = {
		rootMarkers = { ".git/" },
		languages = languages,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}

require("lspconfig").efm.setup(local_vim.tbl_extend("force", efmls_config, {
	-- Pass your custom lsp config below like on_attach and capabilities
	--
	-- on_attach = on_attach,
	-- capabilities = capabilities,
}))

local lsp_fmt_group = local_vim.api.nvim_create_augroup("LspFormattingGroup", {})
local_vim.api.nvim_create_autocmd("BufWritePost", {
	group = lsp_fmt_group,
	callback = function(ev)
		local efm = local_vim.lsp.get_clients({ name = "efm", bufnr = ev.buf })

		if local_vim.tbl_isempty(efm) then
			return
		end

		local_vim.lsp.buf.format({ name = "efm" })
	end,
})
