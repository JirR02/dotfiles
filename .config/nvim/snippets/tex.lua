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

-- Conditions --

local function math()
	return vim.api.nvim_eval("vimtex#syntax#in_mathzone()") == 1
end

-- Snippets --

local item = s(
	{ trig = "-it", desc = "Itemize & Enumerate Item" },
	fmt(
		[[
\item {}
]],
		{
			i(1, "Bulletpoint"),
		}
	)
)
table.insert(autosnippets, item)

local tableenv = s(
	{ trig = "table(%d) (%d)", regTrig = true, desc = "Table Environment" },
	fmt(
		[[
\begin{{tabular}}{{|{}}}
  \toprule
  {}
  \bottomrule
\end{{tabular}}

{}
]],
		{
			d(1, function(_, snip)
				local col = tonumber(snip.captures[2])
				local result = ""
				for j = 1, col do
					result = result .. "c|"
					j = j + 1
				end
				return sn(nil, t(result))
			end),
			d(2, function(_, snip)
				local col = tonumber(snip.captures[2])
				local row = tonumber(snip.captures[1])
				local node = {}
				local p = 1
				table.insert(node, i(p))
				for j = 1, row - 1 do
					for k = 1, col - 1 do
						p = p + 1
						table.insert(node, t(" & "))
						table.insert(node, i(p))
						k = k + 1
					end
					table.insert(node, t({ "\\\\", "  " }))
					j = j + 1
				end
				for k = 1, col - 1 do
					p = p + 1
					table.insert(node, t(" & "))
					table.insert(node, i(p))
					k = k + 1
				end
				table.insert(node, t("\\\\"))
				return sn(nil, node)
			end),
			i(3, ""),
		}
	)
)
table.insert(autosnippets, tableenv)

local pdf = s(
	{ trig = "-pdf", desc = "Insert PDF" },
	fmt(
		[[
  \includepdf[pages={}]{{pdf/{}}}{}

]],
		{
			i(1, "Page Number or - for all Pages"),
			i(2, "Name of PDF File"),
			i(3, ""),
		}
	)
)
table.insert(autosnippets, pdf)

local fig = s(
	{ trig = "-fig", desc = "Inser Figure" },
	fmt(
		[[
\includegraphics[width=\textwidth]{{fig/{}}}{}
  ]],
		{
			i(1, "Name of Figure"),
			i({ 2, "" }),
		}
	)
)
table.insert(autosnippets, fig)

local figcap = s(
	{ trig = "-capfig", desc = "Inser Figure with Description" },
	fmt(
		[[
\vspace{{0.5cm}}

\includegraphics[width=\textwidth]{{fig/{}}}
\captionof{{figure}}{{{}}}

\vspace{{0.5cm}}

{}
]],
		{
			i(1, "Name of Figure"),
			i(2, "Caption of Figure"),
			i(3, ""),
		}
	)
)
table.insert(autosnippets, figcap)

-- Math --

local matrix = s(
	{ trig = "(.)mat(%d) (%d)", regTrig = true, desc = "Matrix Environment" },
	fmt(
		[[
  \begin{{{}matrix}}
    {}
  \end{{{}matrix}}
  ]],
		{
			d(1, function(_, snip)
				local type = snip.captures[1]
				if type == " " then
					type = ""
				end
				return sn(1, { t(type) })
			end),
			d(2, function(_, snip)
				local col = tonumber(snip.captures[3])
				local row = tonumber(snip.captures[2])
				local node = {}
				local p = 1
				table.insert(node, i(p))
				for j = 1, row - 1 do
					for k = 1, col - 1 do
						p = p + 1
						table.insert(node, t(" & "))
						table.insert(node, i(p))
						k = k + 1
					end
					table.insert(node, t({ "\\\\", "  " }))
					j = j + 1
				end
				for k = 1, col - 1 do
					p = p + 1
					table.insert(node, t(" & "))
					table.insert(node, i(p))
					k = k + 1
				end
				table.insert(node, t("\\\\"))
				return sn(nil, node)
			end),
			rep(1),
		}
	)
)
table.insert(autosnippets, matrix)

local mk = s(
	{ trig = "mk", desc = "Math" },
	fmt(
		[[
${}${}
]],
		{
			i(1, "Math Equation"),
			i(2, ""),
		}
	)
)
table.insert(autosnippets, mk)
--
local md = s(
	{ trig = "md", desc = "Display Math" },
	fmt(
		[[
\[
{}
.\]

{}
]],
		{
			i(1, "Math Equation"),
			i(2, ""),
		}
	)
)
table.insert(autosnippets, md)

local text = s(
	{ trig = "text", desc = "Text in Math Environment" },
	fmt(
		[[
\text{{{}}}{}
]],
		{
			i(1, "Text"),
			i(2, ""),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, text)

local underset = s(
	{ trig = "(%l)(%d)", regTrig = true, desc = "Underset" },
	fmt(
		[[
{}_{}{}
]],
		{
			f(function(_, snip)
				return snip.captures[1]
			end),
			f(function(_, snip)
				return snip.captures[2]
			end),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, underset)

local square = s(
	{ trig = "sq", desc = "Square" },
	fmt(
		[[
    ^2
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, square)

local cube = s(
	{ trig = "cb", desc = "Cube" },
	fmt(
		[[
    ^3
    ]],
		{}
	)
)
table.insert(autosnippets, cube)

local superscript = s(
	{ trig = "tp", desc = "superscript" },
	fmt(
		[[
    ^{}{}
    ]],
		{
			i(1),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, superscript)

local frac = s(
	{ trig = "//", desc = "Fraction with no input" },
	fmt(
		[[
    \frac{{{}}}{{{}}}{}
    ]],
		{
			i(1, "Numerator"),
			i(2, "Denominator"),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, frac)

local formfrac = s(
	{ trig = "(.+)(%))/", regTrig = true, desc = "Fraction with input" },
	fmt(
		[[
    {}{{{}}}{}
    ]],
		{
			f(function(_, snip)
				local input = snip.captures[1]

				i = string.len(input)
				local depth = -1

				while depth < 0 do
					if input:sub(i, i) == ")" then
						depth = depth - 1
					elseif input:sub(i, i) == "(" then
						depth = depth + 1
					end
					i = i - 1
				end
				local result = input:sub(1, i) .. "\\frac{" .. input:sub(i + 2, input:len()) .. "}"
				return result
			end),
			i(1, "Denominator"),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, formfrac)

local hat = s(
	{ trig = "(%w+)hat", regTrig = true, desc = "Hat" },
	fmt(
		[[
    {}{}
    ]],
		{
			f(function(_, snip)
				local input = snip.captures[1]
				local len = input:len()
				local result = ""
				if len > 1 then
					result = "\\widehat{" .. input .. "}"
				else
					result = "\\hat{" .. input .. "}"
				end
				return result
			end),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, hat)

local bar = s(
	{ trig = "(%w+)bar", regTrig = true, desc = "Bar" },
	fmt(
		[[
    {}{}
    ]],
		{
			f(function(_, snip)
				local input = snip.captures[1]
				local len = input:len()
				local result = ""
				if len > 1 then
					result = "\\overline{" .. input .. "}"
				else
					result = "\\bar{" .. input .. "}"
				end
				return result
			end),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, bar)

local tilde = s(
	{ trig = "(%w+)tilde", regTrig = true, desc = "tilde" },
	fmt(
		[[
    {}{}
    ]],
		{
			f(function(_, snip)
				local input = snip.captures[1]
				local len = input:len()
				local result = ""
				if len > 1 then
					result = "\\widetilde{" .. input .. "}"
				else
					result = "\\tilde{" .. input .. "}"
				end
				return result
			end),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, tilde)

local underbrace = s(
	{ trig = "(.+)(%))unbr", regTrig = true, desc = "Underbrace" },
	fmt(
		[[
    {}{}{}
    ]],
		{
			f(function(_, snip)
				local input = snip.captures[1]

				i = string.len(input)
				local depth = -1

				while depth < 0 do
					if input:sub(i, i) == ")" then
						depth = depth - 1
					elseif input:sub(i, i) == "(" then
						depth = depth + 1
					end
					i = i - 1
				end
				local result = input:sub(1, i) .. "\\underbrace{" .. input:sub(i + 2, input:len()) .. "}"
				return result
			end),
			c(1, { t(""), sn(nil, { t("_{"), i(1, "Caption"), t("}") }) }),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, underbrace)

local curlybracesr = s(
	{ trig = "cubr(%d)", regTrig = true, desc = "Curly Braces pointing right" },
	fmt(
		[[
    {} = \left\{{
      \begin{{array}}{{lr}}
        {}
      \end{{array}}
    \right.
    {}
    ]],
		{
			i(1, "Function or Variable"),
			d(2, function(_, snip)
				local row = tonumber(snip.captures[1])
				local node = {}
				for j = 1, row - 1 do
					table.insert(node, i(j))
					table.insert(node, t({ " \\\\", "    " }))
				end
				table.insert(node, t(" \\\\"))
				return sn(nil, node)
			end),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, curlybracesr)

local curlybracesl = s(
	{ trig = "cubl(%d)", regTrig = true, desc = "Curly Braces pointing left" },
	fmt(
		[[
    \left\.
      \begin{{array}}{{rl}}
        {}
      \end{{array}}
    \right}} {}
    {}
    ]],
		{
			d(1, function(_, snip)
				local row = tonumber(snip.captures[1])
				local node = {}
				for j = 1, row - 1 do
					table.insert(node, i(j))
					table.insert(node, t({ " \\\\", "    " }))
				end
				table.insert(node, t(" \\\\"))
				return sn(nil, node)
			end),
			i(2, "Function or Variable"),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, curlybracesl)

local sum = s(
	{ trig = "sum", desc = "Sum" },
	fmt(
		[[
    \sum{}{}
    ]],
		{
			c(1, { t(""), sn(nil, { t("_{"), i(1), t("}^{"), i(2), t("}") }) }),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, sum)

local limit = s(
	{ trig = "lim", desc = "Limit" },
	fmt(
		[[
    \lim_{{{} \to {}}} {}
    ]],
		{
			i(1, "Lower Limit"),
			i(2, "Higher Limit"),
			i(0),
		}
	)
)
table.insert(snippets, limit)

local root = s(
	{ trig = "rt", desc = "Root" },
	fmt(
		[[
    \sqrt{}{{{}}}
    ]],
		{
			c(1, { t(""), sn(nil, { t("["), i(1, "nth root"), t("]") }) }),
			i(2, "Variable or Number"),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, root)

local greaterequal = s(
	{ trig = "geq", desc = "Greater or Equal" },
	fmt(
		[[
    \geq
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, greaterequal)

local lesserequal = s(
	{ trig = "leq", desc = "Lesser or Equal" },
	fmt(
		[[
    \leq
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, lesserequal)

local xn = s(
	{ trig = "xnn", desc = "xn" },
	fmt(
		[[
    x_{{n}}
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, xn)

local yn = s(
	{ trig = "ynn", desc = "yn" },
	fmt(
		[[
    y_{{n}}
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, yn)

local xii = s(
	{ trig = "xii", desc = "xi" },
	fmt(
		[[
    x_{{i}}
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, xii)

local yi = s(
	{ trig = "yii", desc = "yi" },
	fmt(
		[[
    y_{{i}}
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, yi)

local xp1 = s(
	{ trig = "xp1", desc = "x + 1" },
	fmt(
		[[
    x_{{n+1}}
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, xp1)

local xnx = s(
	{ trig = "xn{%w}", desc = "x _ ?" },
	fmt(
		[[
    x_{{{}}}{}
    ]],
		{
			c(1, { f(function(_, snip)
				return snip.captures[1]
			end), i("Variable or Number") }),
			i(0),
		}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, xnx)

local cdot = s(
	{ trig = "*", desc = "cdot" },
	fmt(
		[[
    \cdot
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, cdot)

local leftrightarrow = s(
	{ trig = "lrar", desc = "leftright arrrow" },
	fmt(
		[[
    \leftrightarrow
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, leftrightarrow)

local inverse = s(
	{ trig = "inv", desc = "Inverse" },
	fmt(
		[[
    ^{{-1}}
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, inverse)

local rightarrow = s(
	{ trig = "ra", desc = "Right Arrow" },
	fmt(
		[[
    \rightarrow
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, rightarrow)

local leftarrow = s(
	{ trig = "la", desc = "Left Arrow" },
	fmt(
		[[
    \leftarrow
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, leftarrow)

-- Greek Letters --

local degree = s(
	{ trig = "deg", desc = "degree" },
	fmt(
		[[
    ^{{\circ}}
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, degree)

local Gamma = s(
	{ trig = "Gamma", desc = "Gamma" },
	fmt(
		[[
    \Gamma
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Gamma)

local Delta = s(
	{ trig = "Delta", desc = "Delta" },
	fmt(
		[[
    \Delta
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Delta)

local Lambda = s(
	{ trig = "Lambda", desc = "Lambda" },
	fmt(
		[[
    \Lambda
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Lambda)

local Phi = s(
	{ trig = "Phi", desc = "Phi" },
	fmt(
		[[
    \Phi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Phi)

local Pi = s(
	{ trig = "Pi", desc = "Pi" },
	fmt(
		[[
    \Pi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Pi)

local Psi = s(
	{ trig = "Psi", desc = "Psi" },
	fmt(
		[[
    \Psi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Psi)

local Sigma = s(
	{ trig = "Sigma", desc = "Sigma" },
	fmt(
		[[
    \Sigma
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Sigma)

local Theta = s(
	{ trig = "Theta", desc = "Theta" },
	fmt(
		[[
    \Theta
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Theta)

local Epsilon = s(
	{ trig = "Epsilon", desc = "Epsilon" },
	fmt(
		[[
    \Upsilon
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Epsilon)

local Xi = s(
	{ trig = "Xi", desc = "Xi" },
	fmt(
		[[
    \Xi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Xi)

local Omega = s(
	{ trig = "Omega", desc = "Omega" },
	fmt(
		[[
    \Omega
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, Omega)

local alpha = s(
	{ trig = "aloha", desc = "alpha" },
	fmt(
		[[
    \alpha
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, alpha)

local beta = s(
	{ trig = "beta", desc = "beta" },
	fmt(
		[[
    \beta
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, beta)

local gamma = s(
	{ trig = "gamma", desc = "gamma" },
	fmt(
		[[
    \gamma
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, gamma)

local delta = s(
	{ trig = "delta", desc = "delta" },
	fmt(
		[[
    \delta
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, delta)

local epsilon = s(
	{ trig = "epsilon", desc = "epsilon" },
	fmt(
		[[
    \epsilon
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, epsilon)

local zeta = s(
	{ trig = "zeta", desc = "zeta" },
	fmt(
		[[
    \zeta
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, zeta)

local eta = s(
	{ trig = "eta", desc = "eta" },
	fmt(
		[[
    \eta
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, eta)

local theta = s(
	{ trig = "theta", desc = "theta" },
	fmt(
		[[
    \theta
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, theta)

local iota = s(
	{ trig = "iota", desc = "iota" },
	fmt(
		[[
    \iota
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, iota)

local kappa = s(
	{ trig = "kappa", desc = "kappa" },
	fmt(
		[[
    \kappa
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, kappa)

local lambda = s(
	{ trig = "lambda", desc = "lambda" },
	fmt(
		[[
    \lambda
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, lambda)

local mu = s(
	{ trig = "mu", desc = "mu" },
	fmt(
		[[
    \mu
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, mu)

local nu = s(
	{ trig = "nu", desc = "nu" },
	fmt(
		[[
    \nu
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, nu)

local xi = s(
	{ trig = "xi", desc = "xi" },
	fmt(
		[[
    \xi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, xi)

local pi = s(
	{ trig = "pi", desc = "pi" },
	fmt(
		[[
    \pi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, pi)

local rho = s(
	{ trig = "rho", desc = "rho" },
	fmt(
		[[
    \rho
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, rho)

local sigma = s(
	{ trig = "sigma", desc = "sigma" },
	fmt(
		[[
    \sigma
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, sigma)

local tau = s(
	{ trig = "tau", desc = "tau" },
	fmt(
		[[
    \tau
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, tau)

local upsilon = s(
	{ trig = "upsilon", desc = "upsilon" },
	fmt(
		[[
    \upsilon
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, upsilon)

local phi = s(
	{ trig = "phi", desc = "phi" },
	fmt(
		[[
    \phi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, phi)

local chi = s(
	{ trig = "chi", desc = "chi" },
	fmt(
		[[
    \chi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, chi)

local psi = s(
	{ trig = "psi", desc = "psi" },
	fmt(
		[[
    \psi
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, psi)

local omega = s(
	{ trig = "omega", desc = "omega" },
	fmt(
		[[
    \omega
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, omega)

local vepsilon = s(
	{ trig = "vepsilon", desc = "vepsilon" },
	fmt(
		[[
    \varepsilon
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, vepsilon)

local vrho = s(
	{ trig = "vrho", desc = "varrho" },
	fmt(
		[[
    \varrho
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, vrho)

local vtheta = s(
	{ trig = "vtheta", desc = "vartheta" },
	fmt(
		[[
    \vartheta
    ]],
		{}
	),
	{
		condition = math,
		show_condition = math,
	}
)
table.insert(autosnippets, vtheta)

-- End Snippets --

return snippets, autosnippets
