return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    init = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "rust",
                "typescript" },
            auto_install = true,
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
