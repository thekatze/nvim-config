return {
    {
        "thekatze/dyno.nvim",
        dev = true,
        config = function()
            local function reload(fn)
                package.loaded["dyno"] = nil
                return fn
            end

            vim.keymap.set("n", "<leader>ts", reload(function ()
                require("dyno").example()
            end), {desc = "Typing speed"})
        end
    }
}
