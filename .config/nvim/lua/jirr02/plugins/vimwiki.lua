return {
	"vimwiki/vimwiki",
	init = function()
		vim.g.vimwiki_list = {
			{ path = "/Users/jirayu/Projects/Private/vimwiki_code/", syntax = "markdown", ext = ".md" },
			{ path = "/Users/jirayu/Projects/Private/vimwiki_edu/", syntax = "markdown", ext = ".md" },
		}
	end,
}
