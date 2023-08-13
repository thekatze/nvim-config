return {
    -- TODO: add https://github.com/nvim-telescope/telescope-dap.nvim
    -- TODO: check how to set up for rust dev here https://github.com/simrat39/rust-tools.nvim
    --       or here https://www.youtube.com/watch?v=Mccy6wuq3JE&list=PLep05UYkc6wTWlugE_9Lj6JlLpvSBbkZ_&index=5
    "rcarriga/nvim-dap-ui",
    event = "VeryLazy",
    dependencies = {
        {
            "mfussenegger/nvim-dap",
        },
    },
    init = function()
        local dap = require("dap")

        vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle breakpoint" })

        -- maybe use the functions keys instead, dont know how thats gonna be with the new keyboard
        vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step into" })
        vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Step out" })
        vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Step over" })

        -- TODO: open dap ui after attach
    end,
}
