--
-- Options
--

vim.opt.mouse = ''

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.signcolumn = "yes"

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true -- case insensitive UNLESS capital letters are in search

vim.opt.inccommand = "split"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

-- Don't have `o` add a comment
vim.opt.formatoptions:remove "o"

vim.o.winborder = "solid"

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

--
-- Keybinds
--

vim.g.mapleader = " "

-- helpful command for creating the config
-- vim.keymap.set("n", "<leader>o", "<cmd>update<CR><cmd>source<CR>", { desc = "Shoutout" })

vim.keymap.set("n", "<leader>w", vim.cmd.w, { desc = "Save" })

vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus top window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus bottom window" })

-- visual mode move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- center on scroll
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- center on search jump
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- leader y for yanking into system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { desc = "Yank into system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank into system clipboard" })

-- keep selection on indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- quickfix navigation
vim.keymap.set("n", "<C-p>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<C-n>", "<cmd>cnext<CR>zz")

--
-- Plugins
--

vim.pack.add({
    -- theme
    { src = "https://github.com/nyoom-engineering/oxocarbon.nvim" },

    -- lsp server command line arguments
    { src = "https://github.com/neovim/nvim-lspconfig" },

    -- file exploring
    { src = "https://github.com/stevearc/oil.nvim" },

    -- dependency for a lot of lua plugins (telescope, todo-comments)
    { src = "https://github.com/nvim-lua/plenary.nvim" },

    -- searching everything
    {
        src = "https://github.com/nvim-telescope/telescope.nvim",
        version = vim.version.range("0.1.8")
    },

    -- nice syntax highlighting
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },

    -- sticky function headers
    { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },

    -- automatically close/edit html tags using treesitter
    { src = "https://github.com/windwp/nvim-ts-autotag" },

    -- todo comment usefulness
    { src = "https://github.com/folke/todo-comments.nvim" },

    -- undotree <3
    { src = "https://github.com/mbbill/undotree" },

    -- vim.ui.select is awful by default
    -- this is a deprecated plugin but im not really big on snacks.nvim (the proposed alternative)
    { src = "https://github.com/stevearc/dressing.nvim" }
})

vim.cmd.colorscheme("oxocarbon")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

require("telescope").setup()

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Files" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Help" })
vim.keymap.set("n", "<leader>t", builtin.live_grep, { desc = "Text" })
vim.keymap.set("n", "<leader>d", builtin.diagnostics, { desc = "Diagnostics" })

require("oil").setup({})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Explore" })

require("nvim-treesitter.configs").setup({ highlight = { enable = true } })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle)

require("todo-comments").setup()

--
-- LSP
--

vim.lsp.enable({ "lua_ls", "rust_analyzer" })

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.keymap.set('n', 'gs', vim.diagnostic.open_float)

vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Definitions" })

vim.keymap.set("n", "grr", builtin.lsp_references, { desc = "References" })
vim.keymap.set("n", "gri", builtin.lsp_implementations, { desc = "Implementations" })
vim.keymap.set("n", "<leader>s", builtin.lsp_workspace_symbols, { desc = "Symbols" })

vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })

-- <C-y> is NOT comfy for accepting completions
vim.keymap.set("i", "<C-h>", "<C-y>", { desc = "Accept completion" })

vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
        end
    end,
})

vim.cmd("set completeopt+=noselect")
