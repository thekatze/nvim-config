return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v2.x",
    event = "VeryLazy",
    dependencies = {
        -- LSP Support
        { "neovim/nvim-lspconfig" },
        {
            "williamboman/mason.nvim",
            build = function()
                pcall(vim.cmd, "MasonUpdate")
            end,
        },
        { "williamboman/mason-lspconfig.nvim" },
        {
            "folke/neodev.nvim",
            opts = {}
        }, -- configure lua lsp for neovim config

        -- Autocompletion
        { "hrsh7th/nvim-cmp" },
        { "hrsh7th/cmp-nvim-lsp" },
        { "hrsh7th/cmp-buffer" },
        { "hrsh7th/cmp-path" },
        { "L3MON4D3/LuaSnip" },
        { "rafamadriz/friendly-snippets" },
        {
            'j-hui/fidget.nvim',
            tag = 'legacy',
            opts = {
                text = {
                    spinner = "arc",
                }
            },
            event = "LspAttach",
        },
    },
    init = function()
        local lsp = require("lsp-zero").preset({})

        lsp.on_attach(function(client, bufnr)
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "gd", builtin.lsp_definitions, { desc = "Go to definition", buffer = bufnr })
            vim.keymap.set("n", "gI", builtin.lsp_implementations, { desc = "Go to implementations", buffer = bufnr })
            vim.keymap.set("n", "gr", builtin.lsp_references, { desc = "Go to references", buffer = bufnr })
            vim.keymap.set("n", "gs", vim.diagnostic.open_float, { desc = "Show line diagnostics", buffer = bufnr })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show lsp info", buffer = bufnr })

            vim.keymap.set("n", "<leader>ls", builtin.lsp_document_symbols,
                { desc = "Document Symbols", buffer = bufnr })
            vim.keymap.set("n", "<leader>lS", builtin.lsp_workspace_symbols,
                { desc = "Workspace Symbols", buffer = bufnr })
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format", buffer = bufnr })
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })

            vim.keymap.set("n", "<leader>ld", builtin.diagnostics, { desc = "Diagnostics", buffer = bufnr })
        end)

        local lspconfig = require("lspconfig")

        lspconfig.lua_ls.setup(lsp.nvim_lua_ls())

        lsp.setup()

        lspconfig.rust_analyzer.setup {
            -- Server-specific settings. See `:help lspconfig-setup`
            settings = {
                ['rust-analyzer'] = {
                    checkOnSave = {
                        command = "clippy"
                    },
                },
            },
        }

        local cmp = require("cmp")
        local cmp_select_opts = { behavior = cmp.SelectBehavior.Select }

        cmp.setup({
            sources = cmp.config.sources(
                {
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            mapping = {
                ["<Tab>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-n>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_next_item(cmp_select_opts)
                    else
                        cmp.complete()
                    end
                end),
                ["<C-p>"] = cmp.mapping(function()
                    if cmp.visible() then
                        cmp.select_prev_item(cmp_select_opts)
                    else
                        cmp.complete()
                    end
                end),
            }
        })
    end
}
