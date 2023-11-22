return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"onsails/lspkind.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local wk = require("which-key")
		local capabilities = cmp_nvim_lsp.default_capabilities()

		lspconfig["lua_ls"].setup({
			capabilities = capabilities,
			settings = { -- custom settings for lua
				Lua = {
					-- make the language server recognize "vim" global
					diagnostics = {
						globals = { "vim" },
					},
					workspace = {
						-- make language server aware of runtime files
						library = {
							[vim.fn.expand("$VIMRUNTIME/lua")] = true,
							[vim.fn.stdpath("config") .. "/lua"] = true,
						},
					},
				},
			},
		})
		lspconfig["pyright"].setup({
			capabilities = capabilities,
			filetypes = { "python" },
		})
		lspconfig["clangd"].setup({
			capabilities = capabilities,
		})
		lspconfig["marksman"].setup({
			capabilities = capabilities,
		})
		lspconfig["texlab"].setup({
			capabilities = capabilities,
		})
		wk.register({
			l = {
				name = "lsp",
				r = { "<cmd>Telescope lsp_references<CR>", "Show references" },
				D = { "<cmd>lua vim.lsp.buf.defenition()<CR>", "Show defenition" },
				c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code actions" },
				R = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Smart rename" },
				d = { "<cmd>Telescope diagnostics bufnr=0<CR>", "Diagnostics" },
				l = { "<cmd>lua vim.lsp.buf.open_float()<CR>", "Line Diagnostics" },
				n = { "<cmd>lua vim.diagnostics.goto_next()<CR>", "Go to next Diagnostic" },
				p = { "<cmd>lua vim.diagnostics.goto_prev()<CR>", "Go to previous Diagnostic" },
				i = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Show documentation" },
				L = { "<cmd>LspRestart<CR>", "Restart LSP" },
			},
		}, { prefix = "<leader>" })
	end,
}
