return {
	formatting = {
		args = function(_)
			local prettier_roots = {
				".editroconfig",
				".prettierrc",
				".prettierrc.json",
				".prettierrc.yaml",
				".prettierrc.toml",
				".prettierrc.js",
				".prettierrc.mjs",
				".prettierrc.cjs",
				"prettier.config.js",
				"prettier.config.mjs",
				"prettier.config.cjs",
			}

			local args = {
				"--tab-width",
				"4",
				"--no-semi",
				"--no-bracket-spacing",
				"--single-quote",
				"--stdin-filepath",
				"$FILENAME",
			}

			local disable_prettier_global = os.getenv("DISABLE_GLOBAL_PRETTIER_CONFIG")

			local global_prettier_config = vim.fs.find(prettier_roots, {
				path = vim.fn.stdpath("config"),
				type = "file",
			})[1]

			local local_prettier_config = vim.fs.find(prettier_roots, {
				upward = true,
				type = "file",
			})[1]

			local tailwind_prettier_plugin = vim.fs.find("node_modules/prettier-plugin-tailwindcss", {
				upward = true,
				path = vim.fs.dirname(vim.api.nvim_buf_get_name(0)),
				type = "directory",
			})[1]

			if tailwind_prettier_plugin then
				vim.list_extend(args, { "--plugin", "prettier-plugin-tailwindcss" })
			end

			if local_prettier_config then
				args = { "--config", local_prettier_config, "--stdin-filepath", "$FILENAME" }
			elseif global_prettier_config and not disable_prettier_global then
				args = { "--config", global_prettier_config, "--stdin-filepath", "$FILENAME" }
			end

			return args
		end,
	},
}
