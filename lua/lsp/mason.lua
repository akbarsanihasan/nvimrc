return {
	{
		"williamboman/mason.nvim",
		opts = {
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
		},
		opts = function()
			local opts = {}

			opts.automatic_installation = true
			opts.ensure_installed = {
				"gopls",
				"rust_analyzer",
				"phpactor",
				"intelephense",
				"ts_ls",
				"eslint",
				"lua_ls",

				"html",
				"cssls",
				"emmet_ls",
				"htmx",
				"tailwindcss",
			}

			return opts
		end,
	},
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"nvimtools/none-ls.nvim",
		},
		opts = {
			automatic_installation = true,
			ensure_installed = {
				"prettier",
				"php-cs-fixer",
				"stylua",
				"shfmt",
			},
		},
	},
}
