-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- migrated from lunarvim
  {
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-go",
    "nvim-neotest/neotest-jest",
    "nvim-neotest/nvim-nio",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-plenary",
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
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function()
      -- luacheck: ignore 113
      vim.fn["mkdp#util#install"]()
    end,
  },
}
