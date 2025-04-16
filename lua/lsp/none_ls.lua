return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local none_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")
		local helpers = require("Utils.helpers")
		local lsp_utils = require("Utils.lsp")
		local sources = helpers.require_all("lsp/sources")
		local source_names = vim.tbl_keys(sources)
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		local opts = {
			automatic_installation = true,
			ensure_installed = {
				"prettier",
				"php-cs-fixer",
				"stylua",
				"shellharden",
			},
			handlers = {
				function(source, methods)
					if next(methods) == nil then
						return
					end

					for _, method in ipairs(methods) do
						if vim.tbl_contains(source_names, source) then
							none_ls.register(none_ls.builtins[method][source].with(sources[source][method]))
						else
							none_ls.register(none_ls.builtins[method][source])
						end
					end
				end,
			},
		}

		none_ls.setup({
			on_attach = function(client, bufnr)
				lsp_utils.on_attach(client, bufnr)

				if client:supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								timeout_ms = 2000,
								async = false,
							})
						end,
					})
				end
			end,
		})

		mason_null_ls.setup(opts)
	end,
}
