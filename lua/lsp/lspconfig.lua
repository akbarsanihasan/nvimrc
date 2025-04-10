return {
	"neovim/nvim-lspconfig",
	dependencies = { "williamboman/mason-lspconfig.nvim" },
	command = "BufEnter",
	config = function()
		local mason_lspconfig = require("mason-lspconfig")
		local lsp_utils = require("Utils.lsp")
		local servers = require("Utils.helpers").require_all("lsp/providers")

		table.insert(servers, 1, function(server_name)
			require("lspconfig")[server_name].setup({
				require_cwd = false,
				capabilities = lsp_utils.capabilities(),
				on_attach = lsp_utils.on_attach,
				single_file_support = true,
			})
		end)

		mason_lspconfig.setup({
			handlers = servers,
		})
	end,
}
