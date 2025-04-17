return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local lsp_utils = require("Utils.lsp")
		local helpers = require("Utils.helpers")
		local providers = helpers.require_all("lsp/providers")
		local provider_names = vim.tbl_keys(providers)

		mason_lspconfig.setup({
			automatic_installation = true,
			ensure_installed = {
				"gopls",
				"phpactor",
				"clangd",
				"rust_analyzer",
				"ts_ls",
				"lua_ls",
				"html",
				"cssls",
				"htmx",
			},
			handlers = {
				function(provider_name)
					local server_config = {}
					local default_server_config = {
						require_cwd = false,
						single_file_support = true,
						capabilities = lsp_utils.capabilities(),
						on_attach = lsp_utils.on_attach,
					}

					if vim.tbl_contains(provider_names, provider_name) then
						server_config = vim.tbl_deep_extend(
							"force",
							{},
							default_server_config,
							helpers.return_call(providers[provider_name], "table")
						)
					else
						server_config = default_server_config
					end

					lspconfig[provider_name].setup(server_config)
				end,
			},
		})
	end,
}
