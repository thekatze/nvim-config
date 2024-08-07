return {
    "akinsho/toggleterm.nvim",
    version = "*",
    event = "VeryLazy",
    opts = {},
    config = function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            hidden = true,
            direction = "float",
            dir = "git_dir",
            autochdir = true,
            -- function to run on opening the terminal
            on_open = function(term)
                vim.cmd("startinsert!")
                vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>",
                    { noremap = true, silent = true })
            end,
        });

        vim.keymap.set("n", "<leader>g", function() lazygit:toggle() end, { desc = "lazygit" })

        local SimpleTerm = Terminal:new({
            hidden = true,
            direction = "float",
            dir = "git_dir",
            on_open = function()
                vim.cmd("startinsert!")
            end
        })

        vim.keymap.set({ "n", "t" }, "<C-t>", function() SimpleTerm:toggle() end, { desc = "Open terminal" })
    end
}
