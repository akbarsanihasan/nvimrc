return {
	single_file_support = true,
	root_dir = function(fname)
		return require("lspconfig.util").root_pattern("composer.json", ".git")(fname) or vim.fn.getcwd()
	end,
}
