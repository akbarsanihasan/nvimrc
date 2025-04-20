return {
	"nvim-treesitter/nvim-treesitter",
	main = "nvim-treesitter.configs",
	build = ":TSUpdate",
	dependencies = {
		"nvim-treesitter/nvim-treesitter-context",
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	opts = {
		auto_install = true,
		indent = { enable = true },
		highlight = {
			enable = true,
			additional_vim_regex_highlighting = false,
		},
		ensure_installed = {
			"c",
			"rust",
			"go",
			"php",
			"javascript",
			"typescript",
			"lua",

			"blade",
			"html",
			"css",
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "<C-space>",
				node_incremental = "<C-space>",
				node_decremental = "<bs>",
				scope_incremental = false,
			},
		},
	},
	config = function(_, opts)
		local treesitter = require("nvim-treesitter.configs")
		local parser_config = require("nvim-treesitter.parsers").get_parser_configs()

		vim.filetype.add({
			pattern = {
				[".*%.blade%.php"] = "blade",
				[".*/hypr/.*%.conf"] = "hyprlang",
			},
		})

		parser_config.blade = {
			install_info = {
				url = "https://github.com/EmranMR/tree-sitter-blade",
				files = { "src/parser.c" },
				branch = "main",
			},
			filetype = "blade",
		}

		treesitter.setup(opts)
	end,
}
