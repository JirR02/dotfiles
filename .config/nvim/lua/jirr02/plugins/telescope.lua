return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local telescope = require("telescope")
		local wk = require("which-key")

		telescope.load_extension("fzf")

		wk.register({
			f = {
				name = "file",
				f = { "<cmd>Telescope find_files<CR>", "Find Files in Current Working Directory" },
				r = { "<cmd>Telescope oldfiles<CR>", "Recent Files" },
				s = { "<cmd>Telescope grep_string<CR>", "Find String in File" },
				g = { "<cmd>Telescope git_files<CR>", "Find git files" },
			},
		}, { prefix = "<leader>" })
	end,
}
