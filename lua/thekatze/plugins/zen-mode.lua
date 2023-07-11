return {
    "folke/zen-mode.nvim",
    init = function()
        local zenmode = require("zen-mode")
        vim.keymap.set("n", "<leader>zz", zenmode.toggle, { desc = "Zen mode" })
    end
}
