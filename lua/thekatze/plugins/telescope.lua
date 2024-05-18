local handle_error = require("thekatze.util").handle_error

return {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.6",
        event = "VeryLazy",
        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build =
                "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build"
            },
        },
        opts = {
            defaults = {
                prompt_prefix = "( 👁️ ᴗ 👁️ ) ",
                selection_caret = "ඞ ",
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
        },
        init = function()
            require('telescope').load_extension('fzf')
            local builtin = require("telescope.builtin")

            vim.keymap.set("n", "<C-f>", builtin.current_buffer_fuzzy_find, { desc = "Find in file" })

            vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Fuzzy find File" })

            vim.keymap.set("n", "<leader>sf", handle_error(builtin.git_files, "Not a git repository"),
                { desc = "Open git file" })
            vim.keymap.set("n", "<leader>st", builtin.live_grep, { desc = "Text" })
            vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Buffer" })
            vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Help" })
            vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Commands" })
            vim.keymap.set("n", "<leader>sj", builtin.jumplist, { desc = "Jumplist" })
            vim.keymap.set("n", "<leader>ss", builtin.treesitter, { desc = "LSP Symbols" })
        end
    },
}
