return function()
	require("lspconfig").phpactor.setup({
		single_file_support = true,
		capabilities = require("Utils.lsp").capabilities(),
		on_attach = require("Utils.lsp").on_attach,
		root_dir = function(fname)
			return require("lspconfig.util").root_pattern("composer.json", ".git")(fname) or vim.fn.getcwd()
		end,
	})
end
