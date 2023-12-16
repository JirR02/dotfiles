return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup()

		mason_lspconfig.setup({
			ensure_installed = {
				"lua_ls",
				"pyright",
				"clangd",
				"marksman",
				"texlab",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"mypy",
				"ruff",
				"black",
				"clang-format",
				"stylua",
				"prettier",
				"vale",
			},
		})
	end,
}
