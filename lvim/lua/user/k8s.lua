local schema_sources_base = {
	kubernetes = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/",
	jsonschemastore = "https://json.schemastore.org/",
}

local schema_sources = {
	kubernetes = schema_sources_base.kubernetes .. "v1.32.1-standalone-strict/all.json",
	actions = schema_sources_base.jsonschemastore .. "github-workflow.json",
	chart = schema_sources_base.jsonschemastore .. "chart.json",
}

local yamlls_config_options = {
	capabilities = require("cmp_nvim_lsp").default_capabilities(),
	flags = {
		debounce_text_changes = 150,
	},
	settings = {
		yaml = {
			schemas = {
				[schema_sources.actions] = "/.github/workflows/*.{yaml,yml}",
				[schema_sources.chart] = "Chart.{yml,yaml}",
				[require("kubernetes").yamlls_schema()] = "{templates,clusters,common}/**/*.{yaml,yml}",
			},
			completion = true,
			validate = true,
			format = { enable = true },
			hover = true,
			schemaStore = {
				enable = true,
				url = "https://www.schemastore.org/api/json/catalog.json",
			},
			schemaDownload = { enable = true },
			trace = { server = "debug" },
		},
	},
}

local lspconfig = require("lspconfig")
lspconfig.yamlls.setup(yamlls_config_options)
lspconfig.helm_ls.setup({
	settings = {
		["helm-ls"] = {
			logLevel = "debug",
			valuesFiles = {
				mainValuesFile = "values.yaml",
				lintOverlayValuesFile = "values.lint.yaml",
				additionalValuesFilesGlobPattern = "values*.yaml",
			},
			yamlls = {
				enabled = true,
				enabledForFilesGlob = "*.{yaml,yml}",
				diagnosticsLimit = 50,
				showDiagnosticsDirectly = true,
				schemaStore = {
					enable = true,
					url = "https://www.schemastore.org/api/json/catalog.json",
				},
				path = "yaml-language-server",
				config = yamlls_config_options.settings.yaml,
			},
		},
	},
})

-- Disable lsp for helm values files
local local_vim = vim -- luacheck:ignore 113
local_vim.api.nvim_create_autocmd("LspAttach", {
	group = local_vim.api.nvim_create_augroup("DisableLspForValues", {}),
	pattern = { "values.yaml", "value*.yml", "value*.yaml", "*values.yaml", "*values.yml" },
	command = "LspStop",
})
