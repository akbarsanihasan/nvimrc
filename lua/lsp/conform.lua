return {
	"stevearc/conform.nvim",
	dependencies = { "jay-babu/mason-null-ls.nvim" },
	event = { "BufWritePre" },
	keys = {
		{
			"<leader>fr",
			function()
				require("conform").format({
					format_after_save = {
						lsp_fallback = true,
					},
				})
			end,
		},
	},
	opts = function()
		local opts = {}
		local slow_format_filetypes = {}

		opts.quiet = true
		opts.formatters = require("Utils.helpers").require_all("lsp/formatters")
		opts.formatters_by_ft = {
			lua = { "stylua" },
			php = { "php_cs_fixer" },
			typescript = { "prettier" },
			typescriptreact = { "prettier" },
			javascript = { "prettier" },
			javascriptreact = { "prettier" },

			sh = { "shfmt" },
			bash = { "shfmt" },
			zsh = { "shfmt" },

			html = { "prettier" },
			css = { "prettier" },
			scss = { "prettier" },
			json = { "prettier" },
			jsonc = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
		}

		opts.format_on_save = function(bufnr)
			local bufname = vim.api.nvim_buf_get_name(bufnr)

			if bufname:match("/node_modules/") then
				return
			end

			if slow_format_filetypes[vim.bo[bufnr].filetype] then
				return
			end

			local function on_format(err)
				if err and err:match("timeout$") then
					slow_format_filetypes[vim.bo[bufnr].filetype] = true
				end
			end

			return { timeout_ms = 200, lsp_format = "fallback" }, on_format
		end

		opts.format_after_save = function(bufnr)
			if not slow_format_filetypes[vim.bo[bufnr].filetype] then
				return
			end
			return { lsp_format = "fallback" }
		end

		return opts
	end,
}
