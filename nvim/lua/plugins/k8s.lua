local schema_sources_base = {
  kubernetes = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/",
  jsonschemastore = "https://json.schemastore.org/",
}

local schema_sources = {
  kubernetes = schema_sources_base.kubernetes .. "v1.32.1-standalone-strict/all.json",
  actions = schema_sources_base.jsonschemastore .. "github-workflow.json",
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
        [require("kubernetes").yamlls_schema()] = "{manifests,templates,clusters,common}/**/*.{yaml,yml}",
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

-- luacheck: ignore globals vim
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "yaml", "helm" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "b0o/SchemaStore.nvim",
      version = false, -- last release is way too old
    },
    opts = {
      -- make sure mason installs the server
      servers = {
        yamlls = yamlls_config_options,
        ["helm_ls"] = {
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
        },
      },
    },
  },
}
