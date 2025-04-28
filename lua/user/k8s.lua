-- require("telescope").load_extension("yaml_schema")
-- require('diogo464/kubernetes.nvim').setup {
--   -- this can help with autocomplete. it sets the `additionalProperties` field on type definitions
--   to false if it is not already present.
--   schema_strict = true,
--   -- true:  generate the schema every time the plugin starts
--   -- false: only generate the schema if the files don't already exists. run `:KubernetesGenerateSchema`
--   manually to generate the schema if needed.
--   schema_generate_always = true,
-- }
local opts = {
  -- Built in file matchers
  builtin_matchers = {
    -- Detects Kubernetes files based on content
    kubernetes = { enabled = true },
    cloud_init = { enabled = true }
  },

  -- Additional schemas available in Telescope picker
  schemas = {
    --{
      --name = "Kubernetes 1.22.4",
      --uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json"
    --},
  },

  -- Pass any additional options that will be merged in the final LSP config
  lspconfig = {
    flags = {
      debounce_text_changes = 150,
    },
    settings = {
      redhat = { telemetry = { enabled = false } },
      yaml = {
        validate = true,
        format = { enable = true },
        hover = true,
        schemaStore = {
          enable = true,
          url = "https://www.schemastore.org/api/json/catalog.json",
        },
        schemaDownload = { enable = true },
        schemas = {},
        trace = { server = "debug" },
      },
    },
  },
}
local cfg = require("yaml-companion").setup(opts)
require("lspconfig")["yamlls"].setup(cfg)
require("telescope").load_extension("yaml_schema")


