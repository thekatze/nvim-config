return {
    {
        "thekatze/dyno.nvim",
        dev = true,
        config = function()
            local dyno = require("dyno")

            vim.keymap.set("n", "<leader>ts", dyno.example, {desc = "Typing speed"})
        end
    }
}
