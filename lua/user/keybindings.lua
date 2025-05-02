-- luacheck: ignore 113
local which_key = lvim.builtin.which_key

-- Tabs and Floaterm
which_key.mappings["<left>"] = { "<cmd>BufferLineCyclePrev<cr>", "Previous tab" }
which_key.mappings["<right>"] = { "<cmd>BufferLineCycleNext<cr>", "Next tab" }

-- k9s
which_key.mappings["k"] = {
  name = "K9s",
  k = { "<cmd>FloatermNew --wintype=float --width=0.8 --height=0.8 --position=center k9s<cr>", "Float Window" },
  v = { "<cmd>FloatermNew --wintype=vsplit --width=0.5 --position=center k9s<cr>", "Split Window" },
}

-- Telescope
which_key.mappings["t"] = {
	name = "Telescope",
	f = { "<cmd>Telescope find_files<cr>", "Files" },
	g = { "<cmd>Telescope live_grep<cr>", "Text" },
	b = { "<cmd>Telescope git_branches<cr>", "Branches" },
	p = { "<cmd>Telescope projects<cr>", "Projects" },
	t = { "<cmd>Telescope buffers<cr>", "Buffers" },
}

-- Replace
which_key.mappings["r"] = { "<cmd>lua require('grug-far').open({ transient = true })<cr>", "And Replace" }

-- Goto
which_key.mappings["G"] = {
	name = "Goto",
	d = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Definition" },
	D = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Declaration" },
}

-- Hunk
which_key.mappings["h"] = {
	name = "Hunk",
	p = { "<cmd>Gitsigns preview_hunk<cr>", "Preview" },
	i = { "<cmd>Gitsigns preview_hunk_inline<cr>", "Preview (inline)" },
	r = { "<cmd>Gitsigns reset_hunk<cr>", "Reset" },
	s = { "<cmd>Gitsigns stage_hunk<cr>", "Stage" },
}

-- Hover
which_key.mappings["s"] = {
	name = "Symbol",
	a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Actions" },
	-- TODO solve scope of rename
  r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
	i = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Information" },
	d = { "<cmd>lua vim.diagnostic.open_float()<cr>", "Diagnostics" },
}

-- Terminal
which_key.mappings["`"] = {
	name = "Terminal",
	n = { "<cmd>FloatermNew --wintype=split --height=0.3<cr>", "New" },
	t = { "<cmd>FloatermToggle<cr>", "Toggle" },
}



-- TODO analize this
-- lvim.lsp.buffer_mappings.normal_mode["gr"] = {
--   ":lua require'telescope.builtin'.lsp_references()<cr>",
--   kind.cmp_kind.Reference .. " Find references"
-- }

-- lvim.lsp.buffer_mappings.normal_mode["gd"] = {
--   ":lua vim.lsp.buf.definition()<cr>",
--   -- ":lua require'telescope.builtin'.lsp_definitions()<cr>",
--   kind.cmp_kind.Reference .. " Definitions"
-- }

-- lvim.lsp.buffer_mappings.normal_mode["gD"] = {
--   ":lua vim.lsp.buf.type_definition()<cr>",
--   kind.cmp_kind.Reference .. " Type Definition"
-- }
