return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
        icons = {
            mappings = false,
        },
        delay = 0,
        spec = {
            { "<leader>c", group = "Configure", nowait = false, remap = false },
            { "<leader>d", group = "Debug",     nowait = false, remap = false },
            { "<leader>l", group = "LSP",       nowait = false, remap = false },
            { "<leader>s", group = "Search",    nowait = false, remap = false },
            { "<leader>z", group = "Zen",       nowait = false, remap = false },
       }
    }
}
