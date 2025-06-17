return {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvimtools/none-ls-extras.nvim",
		"jay-babu/mason-null-ls.nvim",
	},
	config = function()
		local helpers = require("Utils.helpers")
		local none_ls = require("null-ls")
		local mason_null_ls = require("mason-null-ls")

		none_ls.setup({
			update_in_insert = false,
		})
		mason_null_ls.setup({
			automatic_installation = true,
			ensure_installed = {
				"prettier",
				"php-cs-fixer",
				"shfmt",
				"shellharden",
			},
			handlers = {
				function(source, methods)
					if methods == nil or vim.tbl_isempty(methods) then
						return
					end

					for _, method in ipairs(methods) do
						local configs = helpers.require_all("server_config/" .. method)
						local servers = vim.tbl_keys(configs)

						if vim.tbl_contains(servers, source) then
							none_ls.register(none_ls.builtins[method][source].with(configs[source]))
						else
							none_ls.register(none_ls.builtins[method][source])
						end
					end
				end,
			},
		})
	end,
}
