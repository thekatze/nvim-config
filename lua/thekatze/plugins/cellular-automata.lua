return {
    "eandrju/cellular-automaton.nvim",
    event = "VeryLazy",
    cmd = "CellularAutomaton",
    config = function()
        vim.keymap.set("n", "<leader>zr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })
    end
}
