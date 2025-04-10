return function()
	require("lspconfig").lua_ls.setup({
		capabilities = require("Utils.lsp").capabilities(),
		on_attach = require("Utils.lsp").on_attach,
		settings = {
			Lua = {
				diagnostics = {
					globals = { "vim", "it", "describe", "before_each", "after_each" },
				},
				workspace = {
					library = {
						[vim.fn.expand("$VIMRUNTIME/lua")] = true,
						[vim.fn.stdpath("config") .. "/lua"] = true,
					},
				},
			},
		},
	})
end
