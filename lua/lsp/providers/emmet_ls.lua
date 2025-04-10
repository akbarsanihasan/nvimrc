return function()
	require("lspconfig").emmet_ls.setup({
		capabilities = require("Utils.lsp").capabilities(),
		on_attach = require("Utils.lsp").on_attach,
		filetypes = {
			"astro",
			"css",
			"eruby",
			"html",
			"htmldjango",
			"javascriptreact",
			"less",
			"pug",
			"sass",
			"scss",
			"svelte",
			"typescriptreact",
			"vue",
			"htmlangular",
			"htmlangular",
			"php",
			"blade",
		},
	})
end
