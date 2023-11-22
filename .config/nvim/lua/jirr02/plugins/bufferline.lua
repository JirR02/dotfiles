return {
	"akinsho/bufferline.nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"ojroques/nvim-bufdel",
	},
	config = function()
		local bufferline = require("bufferline")
		local wk = require("which-key")

		bufferline.setup({
			options = {
				mode = "buffers",
				seperator_style = "slant",
			},
		})

		wk.register({
			b = {
				name = "buffer",
				x = { "<cmd>BufDel<CR>", "Close Buffer" },
				n = { "<cmd>BufferLineCycleNext<CR>", "Go to next buffer" },
				p = { "<cmd>BufferLineCyclePrev<CR>", "Go to previous buffer" },
			},
		}, { prefix = "<leader>" })
	end,
}
