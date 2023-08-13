vim.g.mapleader = " "
vim.keymap.set("n", "<leader>e", vim.cmd.Ex, { desc = "Explore" })

-- open all kinds of config
vim.keymap.set("n", "<leader>cc", "<cmd>tabnew ~/.config/nvim/lua/thekatze/init.lua<CR>", { desc = "Neovim" })
vim.keymap.set("n", "<leader>cl", "<cmd>Lazy<CR>", { desc = "Lazy (Plugins)" })
vim.keymap.set("n", "<leader>cm", "<cmd>Mason<CR>", { desc = "Mason (LSP servers)" })

-- fuck the arrow keys
vim.keymap.set({ "n", "v", "i" }, "<Up>", "")
vim.keymap.set({ "n", "v", "i" }, "<Down>", "")
vim.keymap.set({ "n", "v", "i" }, "<Left>", "")
vim.keymap.set({ "n", "v", "i" }, "<Right>", "")

-- visual mode move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- center on scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center on search jump
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- leader p for pasting in visual mode without overwriting register
vim.keymap.set("x", "<leader>p", "\"_dp", { desc = "Paste w/o register" })

-- leader y for yanking into system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Yank into system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank into system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Yank into system clipboard" })

-- keep selection on indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- quickfix navigation
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")
