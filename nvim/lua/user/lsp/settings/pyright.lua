return {

  cmd = { "pyright-langserver", "--stdio" },
  filetypes = { "python" },
  --root_dir = function(startpath)
  --       return M.search_ancestors(startpath, matcher)
  --  end,
	settings = {
    python = {
      analysis = {
        autosearchPaths = true,
        diagnosicMode = "workspace",
        typeCheckingMode = "off"
      }
    }
	},
}
