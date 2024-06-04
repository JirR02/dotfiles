return {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"L3MON4D3/LuaSnip", -- snippet engine
		"saadparwaiz1/cmp_luasnip", -- for autocompletion
		"rafamadriz/friendly-snippets", -- useful snippets
		"onsails/lspkind.nvim",
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")

		require("luasnip.loaders.from_vscode").lazy_load()
		require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })

		luasnip.filetype_extend("vimwiki", { "markdown" })

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},
			snippet = { -- configure how nvim-cmp interacts with snippet engine
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},
			mapping = cmp.mapping.preset.insert({
				["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
				["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
				["<C-s>"] = cmp.mapping.abort(), -- close completion window
				["<CR>"] = cmp.mapping.confirm({ select = false }),
				["<C-n>"] = cmp.config.disable,
				["<C-p>"] = cmp.config.disable,
				["<C-h>"] = cmp.config.disable,
				["<C-e>"] = cmp.config.disable,
			}),
			sources = cmp.config.sources({
				{ name = "luasnip" }, -- snippets
				{ name = "nvim_lsp" }, -- LSP
				{ name = "buffer" }, -- text within current buffer
				{ name = "path" }, -- file system paths
			}),
			formatting = {
				format = lspkind.cmp_format({
					maxwidth = 50,
					ellipsis_char = "...",
				}),
			},
		})
		luasnip.config.set_config({
			history = true,
			updateevents = "TextChanged, TextChangedI",
			enable_autosnippets = true,
		})

		vim.keymap.set({ "i" }, "<C-e>", function()
			luasnip.expand()
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-l>", function()
			luasnip.jump(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-h>", function()
			luasnip.jump(-1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-n>", function()
			luasnip.change_choice(1)
		end, { silent = true })
		vim.keymap.set({ "i", "s" }, "<C-p>", function()
			luasnip.change_choice(-1)
		end, { silent = true })
	end,
}
