return {
	"williamboman/mason.nvim",
	lazy = true,
	config = function()
		local mason = require("mason")
		local mason_lspconfig = require("mason-lspconfig")
		local mason_null_ls = require("mason-null-ls")

		mason.setup({
			max_concurrent_installers = #vim.loop.cpu_info() / 2,
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = {
				"clangd",
				"gopls",
				"rust_analyzer",
				"phpactor",
				"ts_ls",
				"eslint",
				"lua_ls",

				"html",
				"cssls",
				"emmet_ls",
				"htmx",
				"tailwindcss",
			},
		})

		mason_null_ls.setup({
			automatic_installation = true,
			ensure_installed = {
				"clang-format",
				"php_cs_fixer",
				"blade-formatter",
				"prettier",
				"stylua",
				"shfmt",
				"bashls",
			},
		})
	end,
}
