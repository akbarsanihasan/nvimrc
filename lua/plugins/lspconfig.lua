return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"mason-org/mason.nvim",
		"mason-org/mason-lspconfig.nvim",
	},
	init = function()
		vim.diagnostic.config({
			virtual_text = true,
			update_in_insert = false,
			signs = {
				text = {
					[vim.diagnostic.severity.HINT] = "󰛨",
					[vim.diagnostic.severity.INFO] = "󰌵",
					[vim.diagnostic.severity.WARN] = "󱧡",
					[vim.diagnostic.severity.ERROR] = "",
				},
				texthl = {
					[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
					[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
					[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
				},
			},
		})

		local code_format = function(bufnr)
			vim.lsp.buf.format({
				timeout_ms = 2000,
				async = false,
				bufnr = bufnr,
				filter = function(clt)
					local active_clients = vim.tbl_map(function(client)
						return client.name
					end, vim.lsp.get_clients({ bufnr = bufnr }))

					if vim.tbl_contains(active_clients, "null-ls") then
						return clt.name == "null-ls"
					end

					return true
				end,
			})
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user_lsp_attach", { clear = true }),
			callback = function(event)
				local buffer = event.buf
				local opts = {
					noremap = true,
					silent = true,
					buffer = buffer,
				}

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "]d", function()
					vim.diagnostic.jump({ count = 1, float = true })
				end, opts)
				vim.keymap.set("n", "[d", function()
					vim.diagnostic.jump({ count = -1, float = true })
				end, opts)
				vim.keymap.set("n", "<leader>vdd", vim.diagnostic.open_float, opts)
				vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>vcf", function()
					code_format(buffer)
				end, opts)

				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("user_lsp_format", { clear = true }),
					callback = function()
						code_format(buffer)
					end,
				})
			end,
		})
	end,
	config = function()
		local helpers = require("Utils.helpers")
		local mason_lspconfig = require("mason-lspconfig")
		local lspconfig = helpers.require_all("server_config")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")

		vim.lsp.config("*", {
			require_cwd = false,
			single_file_support = true,
			capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				cmp_nvim_lsp.default_capabilities()
			),
		})

		for server_name, config in pairs(lspconfig) do
			if type(config) == "table" then
				vim.lsp.config(server_name, config)
			end
		end

		mason_lspconfig.setup({
			automatic_enable = true,
			automatic_installation = true,
			ensure_installed = {
				"gopls",
				"phpactor",
				"clangd",
				"rust_analyzer",
				"ts_ls",
				"lua_ls",
				"html",
				"cssls",
				"htmx",
			},
		})
	end,
}
