-- automatically install python syntax highlighting
-- lvim.builtin.treesitter.ensure_installed = {
--   "python",
-- }

-- local function to use with VIRTUAL_ENV

local local_vim = vim -- luacheck:ignore 113

local get_virtualenv = function()
	if os.getenv("VIRTUAL_ENV") then
		return os.getenv("VIRTUAL_ENV") .. "/bin/python"
	else
		return "/usr/bin/python"
	end
end

local get_pythonpath = function(venv_path)
	-- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
	-- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
	-- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
	local cwd = local_vim.fn.getcwd()
	if local_vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
		return cwd .. "/venv/bin/python"
	elseif local_vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
		return cwd .. "/.venv/bin/python"
	else
		return venv_path
	end
end

require("dap-python").setup(get_pythonpath(get_virtualenv()))
