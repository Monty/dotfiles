return require('packer').startup(function(use)
        use 'wbthomason/packer.nvim'
        use 'williamboman/mason.nvim'
        use 'williamboman/mason-lspconfig.nvim'
        use 'neovim/nvim-lspconfig'
        use 'RRethy/nvim-base16'
        use 'themercorp/themer.lua'
end)
