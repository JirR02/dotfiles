local ls = require("luasnip") --{{{
local s = ls.s
local i = ls.i
local t = ls.t

local d = ls.dynamic_node
local c = ls.choice_node
local f = ls.function_node
local sn = ls.snippet_node

local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

local snippets, autosnippets = {}, {} --}}}

-- Start Snippets --

local snip = s(
	{ trig = "snip", desc = "Snippet for LuaSnip" },
	fmt(
		[=[
local {} = s(
  {{ trig = "{}", {}desc = "{}"}},
  fmt(
    [[
    {}
    ]],
    {{
      {}
    }}
  ){}
)
table.insert({}, {})
{}
  ]=],
		{
			i(1, "Name of Snippet"),
			i(2, "Trigger"),
			c(3, { t(""), t("regTrig = true, ") }),
			i(4, "Description"),
			i(5, "Snippet"),
			i(6, "Nodes"),
			c(7, { t(""), t({ ",", "  {", "    condition = math,", "    show_condition=math,", "  }" }) }),
			c(8, { t("snippets"), t("autosnippets") }),
			rep(1),
			i(0),
		}
	)
)
table.insert(snippets, snip)

-- End Snippets --

return snippets, autosnippets
