local lspconfig_path = vim.fn.stdpath("config") .. "/LSPConfig/?.lua"
if not package.path:match(lspconfig_path) then
    package.path = package.path .. ";" .. lspconfig_path
end

require("./settings")
require("./keymap")
if not vim.g.vscode then
    require("./plugin")
end
