return {
    'craftzdog/solarized-osaka.nvim',
    lazy = false,
    priority = 1000,
    opts = {
        termguicolors = true,
    },
    config = function()
        vim.cmd("colorscheme solarized-osaka")
    end,
}

