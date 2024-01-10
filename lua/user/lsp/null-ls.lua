local null_ls_status_ok, null_ls = pcall(require, "null-ls")
local null_ls_helper = require("null-ls.helpers")
if not null_ls_status_ok then
  return
end
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = false,
  sources = {
    formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
    },
    -- formatting.gofumt,
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.google_java_format,
    diagnostics.flake8.with({
       on_output = null_ls_helper.diagnostics.from_pattern(
        [[:(%d+):(%d+): ((%u)%w+) (.*)]],
        { "row", "col", "code", "severity", "message" },
        {
          severities = {
            E = null_ls_helper.diagnostics.severities["warning"], -- Changed to warning!
            W = null_ls_helper.diagnostics.severities["warning"],
            F = null_ls_helper.diagnostics.severities["information"],
            D = null_ls_helper.diagnostics.severities["information"],
            R = null_ls_helper.diagnostics.severities["warning"],
            S = null_ls_helper.diagnostics.severities["warning"],
            I = null_ls_helper.diagnostics.severities["warning"],
            C = null_ls_helper.diagnostics.severities["warning"],
          },
        }
      ),
    }),
  },
}
