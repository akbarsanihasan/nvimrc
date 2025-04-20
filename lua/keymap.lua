local opts = { noremap = true, silent = true }

vim.g.mapleader = " "

vim.keymap.set("i", "<M-leader>", "<ESC>", opts)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

vim.keymap.set({ "n", "v", "x" }, "x", '"_x')
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)
vim.keymap.set("n", "J", "mzJ`z", opts)
vim.keymap.set("n", "n", "nzzzv", opts)
vim.keymap.set("n", "N", "Nzzzv", opts)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- next greatest remap ever : asbjornHaland
vim.keymap.set("v", "<leader>p", '"_dP', opts)
vim.keymap.set("n", "<leader>y", [["+y]], opts)
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts)
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], opts)

vim.keymap.set("n", "<leader>S", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", opts)
vim.keymap.set("n", "<leader><leader>", function()
	vim.cmd("so")
end, opts)
