return {
  {
    "zbirenbaum/copilot.lua",
    opts = {
      panel = { enabled = false },
      filetypes = {
        yaml = true,
        markdown = true,
        help = true,
        gitcommit = true,
        gitrebase = true,
        hgcommit = false,
        svn = false,
        cvs = false,
        ["."] = false,
      },
    },
  },
}
