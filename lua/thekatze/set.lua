if vim.g.neovide then
    vim.o.guifont = "JetBrainsMono Nerd Font"

    -- Helper function for transparency formatting
    local alpha = function()
        return string.format("%x", math.floor((255 * vim.g.transparency) or 0.8))
    end
    -- g:neovide_transparency should be 0 if you want to unify transparency of content and title bar.
    vim.g.neovide_transparency = 0.0
    vim.g.transparency = 0.95
    vim.g.neovide_background_color = "#0f1117" .. alpha()
end

vim.opt.mouse = ""

vim.g.have_nerd_font = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true -- case insensitive UNLESS capital letters are in search

vim.opt.inccommand = "split"

vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 500

-- Don't have `o` add a comment
vim.opt.formatoptions:remove "o"

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- nvim does not know wgsl files yet, set filetype manually if *.wgsl is opened
local wgsl_opened_group = vim.api.nvim_create_augroup("WgslOpened", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = "*.wgsl",
    callback = function()
        vim.bo.filetype = "wgsl"
    end,
    group = wgsl_opened_group
})

