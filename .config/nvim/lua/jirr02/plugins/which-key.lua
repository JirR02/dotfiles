return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	init = function()
		vim.o.timeout = true
		vim.o.timeoutlen = 500
	end,
	config = function()
		local wk = require("which-key")

		wk.setup({
			opts = {},
		})
		wk.register({
			n = {
				name = "vim",
				h = { "<cmd>nohl<CR>", "Close Search Highlights" },
			},
			s = {
				name = "splits",
				v = { "<C-w>v", "Split vertical" },
				s = { "<C-w>s", "Split horizontal" },
				e = { "<C-w>=", "Make Splits equal" },
				x = { "<cmd>close<CR>", "Close Split" },
			},
			m = {
				name = "menu",
				l = { "<cmd>Lazy<CR>", "Open Lazy Menu" },
				m = { "<cmd>Mason<CR>", "Open Mason Menu" },
			},
			g = {
				name = "git",
				t = { "<cmd>Gitsigns toggle_signs<CR>", "Toggle Gitsigns" },
				h = { "<cmd>Gitsigns toggle_linehl<CR>", "Toggle Line Highlights" },
				s = { "<cmd>Telescope git_status<CR>", "git status" },
				d = { "<cmd>Gvdiff<CR>", "Differences" },
				w = { "<cmd>Gwrite<CR>", "Add File" },
				N = { "<cmd>Gitsigns next_hunk<CR>", "Go to next hunk" },
				P = { "<cmd>Gitsigns prev_hunk<CR>", "Go to previous hunk" },
				c = { "<cmd>Git commit<CR>", "Commit" },
				H = { "<cmd>Gitsigns stage_hunk", "Stage hunk" },
				p = { "<cmd>Git push<CR>", "Push" },
				C = { "<cmd>Telescope git_commits<CR>", "View commits" },
				b = { "<cmd>Telescope git_branches<CR>", "View branches" },
			},
		}, { prefix = "<leader>" })
	end,
}
