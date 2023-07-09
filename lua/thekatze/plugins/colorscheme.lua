return {
    {
        "nyoom-engineering/oxocarbon.nvim",
        -- "rebelot/kanagawa.nvim",
        init = function()
            vim.opt.background = "dark"
            vim.cmd.colorscheme("oxocarbon")

            vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
        end
    }
}
