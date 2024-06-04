return {
	"lervag/vimtex",
	config = function()
		local wk = require("which-key")

		vim.g.tex_flavor = "latex"
		vim.g.vimtex_view_method = "zathura"
		vim.g.vimtex_quickfix_mode = 0
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-pdf",
			},
		}

		wk.register({
			v = {
				name = "vimtex",
				c = { ":VimtexCompile", "Compile LaTex File" },
				v = { ":!zathura main.pdf &>/dev/null &", "Open compiled PDF in Zathura" },
			},
		}, { prefix = "<leader>" })
	end,
}
