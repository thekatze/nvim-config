return {
    "eandrju/cellular-automaton.nvim",
    init = function()
        vim.keymap.set("n", "<leader>zr", "<cmd>CellularAutomaton make_it_rain<CR>", { desc = "Make it rain" })
    end
}
