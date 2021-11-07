vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
	use {'dracula/vim', as = 'dracula'}
	use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines
	use 'neovim/nvim-lspconfig' -- use a language server
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/nvim-cmp' -- for completion whilst using the language server
    use 'github/copilot.vim' -- for AI completion
	-- use 'hrsh7th/cmp-copilot'
	use 'saadparwaiz1/cmp_luasnip' -- vim cmp requires luasnip
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    use 'crispgm/nvim-go'
	use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
end)
