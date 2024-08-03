return {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
        local todo = require("todo-comments")
        vim.keymap.set("n", "]t", function()
          todo.jump_next()
        end, { desc = "Next todo comment" })

        vim.keymap.set("n", "[t", function()
          todo.jump_prev()
        end, { desc = "Previous todo comment" })

        todo.setup({})
    end
}
