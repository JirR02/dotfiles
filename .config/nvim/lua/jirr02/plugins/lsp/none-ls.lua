return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"jay-babu/mason-null-ls.nvim",
		"nvimtools/none-ls-extras.nvim",
	},
	config = function()
		local mason_null_ls = require("mason-null-ls")
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
		local formatting = null_ls.builtins.formatting
		local diagnostics = null_ls.builtins.diagnostics

		mason_null_ls.setup()

		null_ls.setup({
			debug = true,
			sources = {
				formatting.stylua,
				formatting.black,
				formatting.clang_format,
				formatting.prettier,
				diagnostics.mypy.with({
					extra_args = function()
						local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_PREFIX") or "/usr"
						return { "--python-executable", virtual .. "/bin/python3" }
					end,
				}),
				-- diagnostics.ruff_lsp,
				diagnostics.vale,
			},
			on_attach = function(current_client, bufnr)
				if current_client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								filter = function(client)
									--  only use null-ls for formatting instead of lsp server
									return client.name == "null-ls"
								end,
								bufnr = bufnr,
							})
						end,
					})
				end
			end,
		})
	end,
}
