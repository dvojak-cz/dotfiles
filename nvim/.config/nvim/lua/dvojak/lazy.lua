-- lazy vim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    -- Add your other plugins here
    {'nvim-telescope/telescope.nvim', tag = '0.1.5', dependencies = { 'nvim-lua/plenary.nvim' } },
    {"nvim-treesitter/nvim-treesitter", run = ":TSUpdate"},
    { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true},
    {"mbbill/undotree"},

     -- LSP Support
    {'williamboman/mason.nvim'},
    {'williamboman/mason-lspconfig.nvim'},
    {'VonHeikemen/lsp-zero.nvim', branch = 'v3.x', lazy = true, config = false},
    {'neovim/nvim-lspconfig', dependencies = {{'hrsh7th/cmp-nvim-lsp'}}},
    -- Autocompletion
    {'hrsh7th/nvim-cmp', dependencies = {{'L3MON4D3/LuaSnip'}}},

    -- GIT
    {'lewis6991/gitsigns.nvim'},

    -- Editor
    {"nvim-neo-tree/neo-tree.nvim", branch = "v3.x", dependencies = {
          "nvim-lua/plenary.nvim",
          "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
          "MunifTanjim/nui.nvim",
          -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
        }
    },
}

require("lazy").setup(plugins, opts)
