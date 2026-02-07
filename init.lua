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

vim.opt.winborder = "solid"

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

-- sensible vertical movement when text is wrapped
vim.keymap.set({"n", "v"}, "j", "gj")
vim.keymap.set({"n", "v"}, "k", "gk")

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

    -- vim.ui.select / vim.ui.input is awful by default
    -- this adds nice ui tweaks and a solid picker
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/folke/todo-comments.nvim" },

    -- undotree <3, but a modern version
    { src = "https://github.com/XXiaoA/atone.nvim" },

    -- completion kinda sucks out of the box, so use blink to make it better
    {
        src = "https://github.com/saghen/blink.cmp",
        version = vim.version.range("1.*")
    },
})

vim.cmd.colorscheme("oxocarbon")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })

require("oil").setup({})
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "Explore" })

require("nvim-treesitter.configs").setup({ highlight = { enable = true } })

require("atone").setup({ ui = { compact = true } })
vim.keymap.set('n', '<leader>u', "<cmd>Atone toggle<CR>")

require("blink.cmp").setup({
    keymap = {
        preset = "default",
        ["<C-h>"] = { "select_and_accept", "fallback" },
        ["<C-n>"] = { "select_next", "show", "fallback" },
    },
    appearance = {
        nerd_font_variant = "mono"
    },
    completion = {
        documentation = {
            auto_show = true
        },
        ghost_text = {
            enabled = true
        }
    },
    sources = {
        default = { "lsp", "path", "snippets", "buffer" }
    },
    fuzzy = {
        implementation = "prefer_rust_with_warning"
    }
})

require("snacks").setup({
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
})

vim.keymap.set("n", "<leader>f", function() Snacks.picker.smart() end, { desc = "Files" })
vim.keymap.set("n", "<leader>h", function() Snacks.picker.help() end, { desc = "Help" })
vim.keymap.set("n", "<leader>t", function() Snacks.picker.grep() end, { desc = "Text" })
vim.keymap.set("n", "<leader>d", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })


require("todo-comments").setup({})
vim.keymap.set("n", "<leader>c", function() Snacks.picker.todo_comments() end, { desc = "Todo comments" })

--
-- LSP
--

vim.lsp.enable({ "lua_ls", "rust_analyzer" })

vim.keymap.set('n', '<leader>lf', vim.lsp.buf.format)

vim.keymap.set('n', 'gs', vim.diagnostic.open_float)

vim.keymap.set("n", "gd", function() Snacks.picker.lsp_definitions() end, { desc = "Definitions" })

vim.keymap.set("n", "grr", function() Snacks.picker.lsp_references() end, { desc = "References" })
vim.keymap.set("n", "gri", function() Snacks.picker.lsp_implementations() end, { desc = "Implementations" })
vim.keymap.set("n", "<leader>s", function() Snacks.picker.lsp_workspace_symbols() end, { desc = "Symbols" })

vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format" })
vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action" })

-- LSP progress in snacks notification: very useful for rust_analyzer because it takes ages to scan the project

---@type table<number, {token:lsp.ProgressToken, msg:string, done:boolean}[]>
local progress = vim.defaulttable()
vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
        local client = vim.lsp.get_client_by_id(ev.data.client_id)
        local value = ev.data.params
            .value --[[@as {percentage?: number, title?: string, message?: string, kind: "begin" | "report" | "end"}]]
        if not client or type(value) ~= "table" then
            return
        end
        local p = progress[client.id]

        for i = 1, #p + 1 do
            if i == #p + 1 or p[i].token == ev.data.params.token then
                p[i] = {
                    token = ev.data.params.token,
                    msg = ("[%3d%%] %s%s"):format(
                        value.kind == "end" and 100 or value.percentage or 100,
                        value.title or "",
                        value.message and (" **%s**"):format(value.message) or ""
                    ),
                    done = value.kind == "end",
                }
                break
            end
        end

        local msg = {} ---@type string[]
        progress[client.id] = vim.tbl_filter(function(v)
            return table.insert(msg, v.msg) or not v.done
        end, p)

        local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
        vim.notify(table.concat(msg, "\n"), "info", {
            id = "lsp_progress",
            title = client.name,
            opts = function(notif)
                notif.icon = #progress[client.id] == 0 and " "
                    or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
            end,
        })
    end,
})
