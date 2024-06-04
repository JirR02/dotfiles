return {
	"folke/noice.nvim",
	dependencies = {
		"MunifTanjim/nui.nvim",
		"rcarriga/nvim-notify",
	},
	config = function()
		local noice = require("noice")

		noice.setup({
			presets = {
				long_message_to_split = true,
			},
		})
	end,
}
