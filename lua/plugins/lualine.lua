return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lualine_mode = require("lualine_require").require("lualine.utils.mode")

		local colors = require("catppuccin.palettes").get_palette("mocha")

		local conditions = {
			buffer_not_empty = function()
				return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
			end,
			hide_in_width = function()
				return vim.fn.winwidth(0) > 80
			end,
			check_git_workspace = function()
				local filepath = vim.fn.expand("%:p:h")
				local gitdir = vim.fn.finddir(".git", filepath .. ";")
				return gitdir and #gitdir > 0 and #gitdir < #filepath
			end,
		}

		local colors_mode = {
			n = colors.peach,
			i = colors.green,
			v = colors.blue,
			[""] = colors.blue,
			V = colors.blue,
			c = colors.mauve,
			no = colors.red,
			s = colors.peach,
			S = colors.peach,
			[""] = colors.peach,
			ic = colors.yellow,
			R = colors.sapphire,
			Rv = colors.sapphire,
			cv = colors.red,
			ce = colors.red,
			r = colors.teal,
			rm = colors.teal,
			["r?"] = colors.cyan,
			["!"] = colors.red,
			t = colors.red,
		}

		local config = {
			options = {
				theme = "catppuccin",
				globalstatus = true,
				component_separators = "",
				section_separators = "",
				ignore_focus = { "TelescopePrompt", "neo-tree", "toggleterm" },
				extensions = { "lazy", "nvim-tree", "toggleterm" },
				disabled_filetypes = {
					statusline = { "lazy", "undotree", "fugitive", "mason", "diff", "TelescopePrompt", "neo-tree" },
					winbar = { "lazy", "undotree", "fugitive", "mason", "diff", "TelescopePrompt", "neo-tree" },
				},
			},
			sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_y = {},
				lualine_z = {},
				lualine_c = {},
				lualine_x = {},
			},
		}

		local function insert_left(component)
			table.insert(config.sections.lualine_c, component)
		end

		local function insert_right(component)
			table.insert(config.sections.lualine_x, component)
		end

		insert_left({
			function()
				return "▍"
			end,
			color = function()
				return { fg = colors_mode[vim.fn.mode()] }
			end,
			padding = { right = 0, left = 0 },
		})

		insert_left({
			lualine_mode.get_mode,
			color = function()
				return { fg = colors_mode[vim.fn.mode()] }
			end,
			icon = "󰼁",
		})

		insert_left({
			"filesize",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.text },
		})

		insert_left({
			"filename",
			cond = conditions.buffer_not_empty,
			color = { fg = colors.mauve, gui = "bold" },
		})

		insert_left({ "location" })

		insert_left({
			"diagnostics",
			sources = { "nvim_diagnostic" },
			symbols = {
				error = " ",
				warn = "󱧡 ",
				info = "󰌵 ",
				hint = "󰛨 ",
			},
			diagnostics_color = {
				error = { fg = colors.red },
				warn = { fg = colors.yellow },
				info = { fg = colors.teal },
				hint = { fg = colors.blue },
			},
		})

		insert_left({
			function()
				return "%="
			end,
		})

		insert_left({
			-- Lsp server name .
			function()
				local msg = "No Active Lsp"
				local buf_ft = vim.api.nvim_get_option_value("filetype", { buf = 0 })
				local clients = vim.lsp.get_clients()
				if next(clients) == nil then
					return msg
				end
				for _, client in ipairs(clients) do
					local filetypes = client.config.filetypes
					if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
						return client.name
					end
				end
				return msg
			end,
			icon = " LSP:",
			color = { fg = colors.text, gui = "bold" },
		})

		insert_right({
			"o:encoding",
			fmt = string.upper,
			cond = conditions.hide_in_width,
			color = { fg = colors.green },
		})

		insert_right({
			"fileformat",
			fmt = string.upper,
			icons_enabled = false,
			color = { fg = colors.green },
		})

		insert_right({
			"branch",
			icon = "",
			color = { fg = colors.blue },
		})

		insert_right({
			"diff",
			symbols = { added = " ", modified = "󰝤 ", removed = " " },
			cond = conditions.hide_in_width,
			diff_color = {
				added = { fg = colors.green },
				modified = { fg = colors.peach },
				removed = { fg = colors.red },
			},
		})

		insert_right({
			function()
				return "▐"
			end,
			color = function()
				return { fg = colors_mode[vim.fn.mode()] }
			end,
			padding = { right = 0, left = 0 },
		})

		lualine.setup(config)
	end,
}
