return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		local neorg = require("neorg")

		neorg.setup({
			load = {
				["core.defaults"] = {},
				["core.completion"] = {
					config = {
						engine = "nvim-cmp",
					},
				},
				["core.integrations.treesitter"] = {},
				["core.concealer"] = {},
				["core.dirman"] = {
					config = {
						workspaces = {
							code = "~/Projects/Private/neorg_code",
							edu = "~/Projects/Private/neorg_edu",
						},
					},
				},
			},
		})
	end,
}
