local handle_error = require("thekatze.util").handle_error

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.2",
        dependencies = { "nvim-lua/plenary.nvim" },
        init = function()
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<leader>f", handle_error(builtin.git_files, "Not a git repository"),
                { desc = "Open git file" })
            vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "File" })
            vim.keymap.set("n", "<leader>st", builtin.live_grep, { desc = "Text" })
            vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Buffer" })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help" })
            vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Commands" })
            vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "Jumplist" })
            vim.keymap.set("n", "<leader>ss", builtin.treesitter, { desc = "LSP Symbols" })
        end
    },
    {
        "nvim-telescope/telescope-fzf-native.nvim",
        build =
        "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
    }
}
