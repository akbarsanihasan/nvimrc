return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	keys = function()
		local builtin = require("telescope.builtin")

		return {
			{ "<C-p>", builtin.find_files, silent = true, noremap = true },
			{ "<leader>pf", builtin.git_files, silent = true, noremap = true },
			{ "<leader>ps", builtin.live_grep, silent = true, noremap = true },
			{
				"<leader>ph",
				function()
					builtin.find_files({
						find_command = {
							"rg",
							"--files",
							"--hidden",
							"--glob",
							"!**/.git/*",
							"--glob",
							"!**/vendor/*",
							"--glob",
							"!**node_modules/*",
						},
					})
				end,
				silent = true,
				noremap = true,
			},
			{
				"<leader>pws",
				function()
					local word = vim.fn.expand("<cword>")
					builtin.grep_string({ search = word })
				end,
				silent = true,
				noremap = true,
			},
			{
				"<leader>pWs",
				function()
					local word = vim.fn.expand("<cWORD>")
					builtin.grep_string({ search = word })
				end,
				silent = true,
				noremap = true,
			},
		}
	end,
	opts = {
		defaults = {
			prompt_prefix = " 󰭎  ",
			selection_caret = " ",
			path_display = { "absolute" },
			sorting_strategy = "ascending",
			layout_strategy = "vertical",
			layout_config = {
				height = 0.6,
				width = 0.4,
				anchor = "N",
				prompt_position = "top",
			},
			mappings = {
				n = {
					["<C-t>"] = "nop",
				},
				i = {
					["<C-t>"] = "nop",
				},
			},
		},
		pickers = {
			live_grep = {
				hidden = true,
			},
		},
	},
}
