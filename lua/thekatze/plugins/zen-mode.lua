return {
    "folke/zen-mode.nvim",
    event = "VeryLazy",
    init = function()
        local zenmode = require("zen-mode")
        vim.keymap.set("n", "<leader>zz", zenmode.toggle, { desc = "Zen mode" })
    end
}
