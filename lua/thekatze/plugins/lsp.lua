return {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
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
            tag = 'v1.4.1',
            opts = {
                progress = {
                    display = {
                        progress_icon = {
                            pattern = "arc",
                        }
                    }
                }
            },
            event = "LspAttach",
        },
    },
    config = function()
        local lsp = require("lsp-zero")

        lsp.on_attach(function(client, bufnr)
            local telescope = require("telescope.builtin")

            -- TODO: definitions are currently broken in telescope, go back to telescope.lsp_definitions once fixed
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition", buffer = bufnr })
            vim.keymap.set("n", "gI", telescope.lsp_implementations, { desc = "Go to implementations", buffer = bufnr })
            vim.keymap.set("n", "gr", telescope.lsp_references, { desc = "Go to references", buffer = bufnr })
            vim.keymap.set("n", "gs", vim.diagnostic.open_float, { desc = "Show line diagnostics", buffer = bufnr })
            vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show lsp info", buffer = bufnr })

            vim.keymap.set("n", "<leader>li", function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, { desc = "Toggle Inlay Hints", buffer = bufnr })

            vim.keymap.set("n", "<leader>ls", telescope.lsp_document_symbols,
                { desc = "Document Symbols", buffer = bufnr })
            vim.keymap.set("n", "<leader>lS", telescope.lsp_workspace_symbols,
                { desc = "Workspace Symbols", buffer = bufnr })
            vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename", buffer = bufnr })
            vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format", buffer = bufnr })
            vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code action", buffer = bufnr })

            vim.keymap.set("n", "<leader>ld", telescope.diagnostics, { desc = "Diagnostics", buffer = bufnr })
            vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Next Diagnostic", buffer = bufnr })
            vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Previous Diagnostic", buffer = bufnr })
        end)

        local lspconfig = require("lspconfig")

        require("mason").setup({})
        require("mason-lspconfig").setup({
            handlers = {
                function(server_name)
                    lspconfig[server_name].setup({})
                end
            }
        })

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
            formatting = lsp.cmp_format(),
            snippet = {
                expand = function(args)
                    require('luasnip').lsp_expand(args.body)
                end
            },
            sources = cmp.config.sources(
                {
                    { name = "copilot" },
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "path" },
                    { name = "buffer" },
                }),
            mapping = {
                ["<C-h>"] = cmp.mapping.confirm({ select = true }),
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
