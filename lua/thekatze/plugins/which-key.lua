return {
    "folke/which-key.nvim",
    init = function()
        local whichkey = require("which-key")

        vim.o.timeout = true
        vim.o.timeoutlen = 0

        local opts = {
            mode = "n",     -- Normal mode
            prefix = "<leader>",
            buffer = nil,   -- Global mappings. Specify a buffer number for buffer local mappings
            silent = true,  -- use `silent` when creating keymaps
            noremap = true, -- use `noremap` when creating keymaps
            nowait = false, -- use `nowait` when creating keymaps
        }

        local mappings = {
            b = {
                name = "Buffer",
                c = { "<Cmd>bd!<Cr>", "Close current buffer" },
                D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
            },
            s = {
                name = "Search",
            }
        }

        whichkey.register(mappings, opts)
    end,
    opts = {
        window = {
            position = "bottom"
        }
    }

}
